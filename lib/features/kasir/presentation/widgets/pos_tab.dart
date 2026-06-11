import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../features/admin/data/models/product_model.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/dialog_action_row.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../data/repositories/order_repository.dart';
import '../providers/order_provider.dart';

class PosTab extends ConsumerStatefulWidget {
  const PosTab({super.key});

  @override
  ConsumerState<PosTab> createState() => _PosTabState();
}

class _PosTabState extends ConsumerState<PosTab> {
  final _searchController = TextEditingController();
  final _paidController = TextEditingController();
  final _tableController = TextEditingController();
  final _notesController = TextEditingController();
  final Map<int, int> _cart = {};

  String? _selectedCategory;
  bool _isSubmitting = false;
  bool _isCartExpanded = false;

  static final _currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    _searchController.dispose();
    _paidController.dispose();
    _tableController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(posProductsProvider);

    return productsState.when(
      loading: () => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, __) => const LoadingWidget.card(),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 5,
      ),
      error: (error, _) => AppErrorWidget(
        error: error,
        onRetry: () => ref.invalidate(posProductsProvider),
      ),
      data: (products) => _buildPos(context, products),
    );
  }

  Widget _buildPos(BuildContext context, List<ProductModel> products) {
    final productMap = {for (final product in products) product.id: product};
    final filteredProducts = _filterProducts(products);
    final categories = products.map((item) => item.category).toSet().toList()
      ..sort();
    final total = _cartTotal(productMap);
    final paid = _parseMoney(_paidController.text);
    final change = paid - total;
    final cartCount = _cart.values.fold<int>(0, (sum, qty) => sum + qty);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(posProductsProvider),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 820;
          final hasCartItems = _cart.isNotEmpty;
          final productPane = _ProductPane(
            products: filteredProducts,
            categories: categories,
            selectedCategory: _selectedCategory,
            searchController: _searchController,
            cart: _cart,
            onSearchChanged: (_) => setState(() {}),
            onCategorySelected: (category) {
              setState(() => _selectedCategory = category);
            },
            onAdd: _addProduct,
            onRemove: _removeProduct,
          );
          final cartPane = _CartPane(
            cart: _cart,
            products: productMap,
            total: total,
            paid: paid,
            change: change,
            cartCount: cartCount,
            paidController: _paidController,
            tableController: _tableController,
            notesController: _notesController,
            isSubmitting: _isSubmitting,
            onChanged: () => setState(() {}),
            onAdd: _addProduct,
            onRemove: _removeProduct,
            onClear: _cart.isEmpty ? null : _confirmClearCart,
            onSubmit: _canSubmit(total, paid)
                ? () => _confirmAndSubmit(total, paid)
                : null,
          );

          return Stack(
            children: [
              ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  hasCartItems ? 104 : 16,
                ),
                children: [productPane],
              ),
              if (hasCartItems && _isCartExpanded)
                Positioned(
                  right: 16,
                  bottom: 88,
                  left: isWide ? null : 16,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWide ? 430 : constraints.maxWidth - 32,
                      maxHeight: constraints.maxHeight * 0.76,
                    ),
                    child: cartPane,
                  ),
                ),
              if (hasCartItems)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: _CartFloatingButton(
                    cartCount: cartCount,
                    total: total,
                    isExpanded: _isCartExpanded,
                    onPressed: () {
                      setState(() => _isCartExpanded = !_isCartExpanded);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  List<ProductModel> _filterProducts(List<ProductModel> products) {
    final query = _searchController.text.trim().toLowerCase();

    return products.where((product) {
      final matchCategory =
          _selectedCategory == null || product.category == _selectedCategory;
      final matchQuery =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);

      return matchCategory && matchQuery;
    }).toList();
  }

  void _addProduct(ProductModel product) {
    final currentQty = _cart[product.id] ?? 0;
    if (currentQty >= product.stock) {
      _showMessage('Stok ${product.name} tidak mencukupi.');
      return;
    }

    setState(() {
      _cart[product.id] = currentQty + 1;
      _isCartExpanded = false;
    });
  }

  void _removeProduct(ProductModel product) {
    final currentQty = _cart[product.id] ?? 0;
    if (currentQty <= 1) {
      setState(() {
        _cart.remove(product.id);
        if (_cart.isEmpty) {
          _isCartExpanded = false;
        }
      });
      return;
    }

    setState(() => _cart[product.id] = currentQty - 1);
  }

  double _cartTotal(Map<int, ProductModel> products) {
    return _cart.entries.fold<double>(0, (sum, entry) {
      return sum + ((products[entry.key]?.price ?? 0) * entry.value);
    });
  }

  bool _canSubmit(double total, double paid) {
    return _cart.isNotEmpty && paid >= total && !_isSubmitting;
  }

  Future<void> _confirmClearCart() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kosongkan keranjang?'),
        content: const Text('Semua item POS akan dihapus dari keranjang.'),
        actions: [
          DialogActionRow(
            cancelLabel: 'Kembali',
            confirmLabel: 'Kosongkan',
            isDestructive: true,
            onCancel: () => Navigator.of(context).pop(false),
            onConfirm: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _cart.clear();
        _isCartExpanded = false;
      });
    }
  }

  Future<void> _confirmAndSubmit(double total, double paid) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Proses pembayaran?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DialogRow(label: 'Total', value: _currency.format(total)),
            _DialogRow(label: 'Dibayar', value: _currency.format(paid)),
            _DialogRow(label: 'Kembali', value: _currency.format(paid - total)),
          ],
        ),
        actions: [
          DialogActionRow(
            cancelLabel: 'Kembali',
            confirmLabel: 'Bayar',
            onCancel: () => Navigator.of(context).pop(false),
            onConfirm: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _submitPos();
    }
  }

  Future<void> _submitPos() async {
    setState(() => _isSubmitting = true);

    try {
      final repository = ref.read(orderRepositoryProvider);
      final result = await repository.createPosTransaction(
        items: _cart.entries
            .map(
              (entry) =>
                  PosItemPayload(productId: entry.key, quantity: entry.value),
            )
            .toList(),
        paidAmount: _parseMoney(_paidController.text),
        tableNumber: _tableController.text.trim(),
        notes: _notesController.text.trim(),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _cart.clear();
        _isCartExpanded = false;
        _paidController.clear();
        _tableController.clear();
        _notesController.clear();
      });
      ref.invalidate(posProductsProvider);

      await _showSuccessDialog(result);
    } catch (error) {
      if (!mounted) {
        return;
      }

      final message = error is AppException
          ? error.message
          : 'Transaksi POS gagal.';
      _showMessage(message);
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _showSuccessDialog(PosTransactionResult result) async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Transaksi #${result.transaction.id} berhasil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DialogRow(
              label: 'Kembalian',
              value: _currency.format(result.change),
            ),
            if (result.receiptUrl != null) ...[
              const SizedBox(height: 12),
              const Text('URL struk'),
              const SizedBox(height: 6),
              SelectableText(result.receiptUrl!),
            ],
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  double _parseMoney(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) {
      return 0;
    }

    return double.tryParse(digitsOnly) ?? 0;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ProductPane extends StatelessWidget {
  const _ProductPane({
    required this.products,
    required this.categories,
    required this.selectedCategory,
    required this.searchController,
    required this.cart,
    required this.onSearchChanged,
    required this.onCategorySelected,
    required this.onAdd,
    required this.onRemove,
  });

  final List<ProductModel> products;
  final List<String> categories;
  final String? selectedCategory;
  final TextEditingController searchController;
  final Map<int, int> cart;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategorySelected;
  final ValueChanged<ProductModel> onAdd;
  final ValueChanged<ProductModel> onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('POS Kasir', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Cari produk',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return FilterChip(
                  label: const Text('Semua'),
                  selected: selectedCategory == null,
                  onSelected: (_) => onCategorySelected(null),
                );
              }

              final category = categories[index - 1];
              return FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (_) => onCategorySelected(category),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: categories.length + 1,
          ),
        ),
        const SizedBox(height: 12),
        if (products.isEmpty)
          const EmptyStateWidget(
            icon: Icons.coffee_outlined,
            title: 'Produk tidak ditemukan',
            subtitle: 'Coba ubah kata kunci atau filter kategori.',
          )
        else
          ...products.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ProductTile(
                product: product,
                quantity: cart[product.id] ?? 0,
                onAdd: () => onAdd(product),
                onRemove: () => onRemove(product),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final canAdd = quantity < product.stock;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.category} - ${_PosTabState._currency.format(product.price)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stok ${product.stock}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Kurangi',
                    onPressed: quantity == 0 ? null : onRemove,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  SizedBox(
                    width: 24,
                    child: Text(
                      '$quantity',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: canAdd ? 'Tambah' : 'Stok habis',
                    onPressed: canAdd ? onAdd : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartPane extends StatelessWidget {
  const _CartPane({
    required this.cart,
    required this.products,
    required this.total,
    required this.paid,
    required this.change,
    required this.cartCount,
    required this.paidController,
    required this.tableController,
    required this.notesController,
    required this.isSubmitting,
    required this.onChanged,
    required this.onAdd,
    required this.onRemove,
    required this.onClear,
    required this.onSubmit,
  });

  final Map<int, int> cart;
  final Map<int, ProductModel> products;
  final double total;
  final double paid;
  final double change;
  final int cartCount;
  final TextEditingController paidController;
  final TextEditingController tableController;
  final TextEditingController notesController;
  final bool isSubmitting;
  final VoidCallback onChanged;
  final ValueChanged<ProductModel> onAdd;
  final ValueChanged<ProductModel> onRemove;
  final VoidCallback? onClear;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final remaining = total - paid;

    return Card(
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.24),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Keranjang',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text('$cartCount item'),
              ],
            ),
            const SizedBox(height: 12),
            if (cart.isEmpty)
              const EmptyStateWidget(
                icon: Icons.shopping_cart_outlined,
                title: 'Keranjang kosong',
                subtitle: 'Pilih produk untuk mulai transaksi POS.',
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 190),
                child: ListView(
                  shrinkWrap: true,
                  children: cart.entries.map((entry) {
                    final product = products[entry.key];
                    if (product == null) {
                      return const SizedBox.shrink();
                    }

                    return _CartItemRow(
                      product: product,
                      quantity: entry.value,
                      onAdd: () => onAdd(product),
                      onRemove: () => onRemove(product),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: tableController,
              decoration: const InputDecoration(
                labelText: 'Nomor meja',
                prefixIcon: Icon(Icons.table_restaurant_outlined),
              ),
              onChanged: (_) => onChanged(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Catatan',
                prefixIcon: Icon(Icons.notes_outlined),
              ),
              maxLines: 2,
              onChanged: (_) => onChanged(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: paidController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Uang dibayar',
                prefixIcon: Icon(Icons.payments_outlined),
              ),
              onChanged: (_) => onChanged(),
            ),
            const SizedBox(height: 14),
            _SummaryRow(
              label: 'Total',
              value: _PosTabState._currency.format(total),
            ),
            const SizedBox(height: 8),
            _SummaryRow(
              label: remaining > 0 ? 'Kurang' : 'Kembalian',
              value: _PosTabState._currency.format(
                remaining > 0 ? remaining : change,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Kosongkan'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(Icons.point_of_sale),
                    label: Text(isSubmitting ? 'Memproses...' : 'Bayar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartFloatingButton extends StatelessWidget {
  const _CartFloatingButton({
    required this.cartCount,
    required this.total,
    required this.isExpanded,
    required this.onPressed,
  });

  final int cartCount;
  final double total;
  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.primary,
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.26),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 16, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isExpanded
                        ? Icons.shopping_cart_checkout
                        : Icons.shopping_cart_outlined,
                    color: colorScheme.onPrimary,
                  ),
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colorScheme.primary),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$cartCount',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.onError,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isExpanded ? 'Tutup keranjang' : 'Lihat keranjang',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _PosTabState._currency.format(total),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.86),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  const _CartItemRow({
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final subtotal = product.price * quantity;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                const SizedBox(height: 2),
                Text(
                  '$quantity x ${_PosTabState._currency.format(product.price)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(_PosTabState._currency.format(subtotal)),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Kurangi',
            onPressed: onRemove,
            icon: const Icon(Icons.remove_circle_outline),
          ),
          IconButton(
            tooltip: 'Tambah',
            onPressed: quantity >= product.stock ? null : onAdd,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _DialogRow extends StatelessWidget {
  const _DialogRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
