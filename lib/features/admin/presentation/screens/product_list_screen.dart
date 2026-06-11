import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/dialog_action_row.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider);
    final gridDelegate = _productGridDelegate(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        actions: [
          IconButton(
            tooltip: 'Tambah produk',
            onPressed: () => context.go('/admin/products/create'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/admin/products/create'),
        icon: const Icon(Icons.add),
        label: const Text('Produk'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(productsProvider),
        child: productsState.when(
          loading: () => GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: gridDelegate,
            itemBuilder: (_, __) => const LoadingWidget.card(),
            itemCount: 6,
          ),
          error: (error, _) => AppErrorWidget(
            error: error,
            onRetry: () => ref.invalidate(productsProvider),
          ),
          data: (products) {
            if (products.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  EmptyStateWidget(
                    icon: Icons.inventory_2_outlined,
                    title: 'Belum ada produk',
                    subtitle: 'Tambahkan produk pertama untuk mulai berjualan.',
                  ),
                ],
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: gridDelegate,
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onEdit: () =>
                      context.go('/admin/products/${product.id}/edit'),
                  onDelete: () => _confirmDelete(context, ref, product.id),
                );
              },
              itemCount: products.length,
            );
          },
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _productGridDelegate(
    BuildContext context,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width < 340 ? 1 : 2;

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: crossAxisCount == 1 ? 1.55 : 0.58,
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    int productId,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hapus produk?'),
            content: const Text('Produk yang dihapus tidak bisa dikembalikan.'),
            actions: [
              DialogActionRow(
                cancelLabel: 'Batal',
                confirmLabel: 'Hapus',
                isDestructive: true,
                onCancel: () => Navigator.of(context).pop(false),
                onConfirm: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref.read(productRepositoryProvider).deleteProduct(productId);
      ref.invalidate(productsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil dihapus')),
        );
      }
    } catch (error) {
      if (context.mounted) {
        final message = error is AppException
            ? error.message
            : 'Gagal menghapus produk';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}
