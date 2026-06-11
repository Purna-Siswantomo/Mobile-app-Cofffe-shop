import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../core/services/laravel_websocket_service.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../features/admin/data/models/product_model.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/connection_indicator.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';
import '../providers/order_provider.dart';
import '../widgets/order_card.dart';
import '../widgets/pos_tab.dart';

class KasirDashboardScreen extends ConsumerStatefulWidget {
  const KasirDashboardScreen({super.key});

  @override
  ConsumerState<KasirDashboardScreen> createState() =>
      _KasirDashboardScreenState();
}

class _KasirDashboardScreenState extends ConsumerState<KasirDashboardScreen> {
  late final LaravelWebSocketService _webSocketService;

  @override
  void initState() {
    super.initState();
    _webSocketService = LaravelWebSocketService()
      ..addListener(_onWebSocketStatusChanged);
    _webSocketService.init(ref);
  }

  @override
  void dispose() {
    _webSocketService
      ..removeListener(_onWebSocketStatusChanged)
      ..disconnect();
    super.dispose();
  }

  void _onWebSocketStatusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  ApiConnectionStatus _apiConnectionStatus(
    List<AsyncValue<List<OrderModel>>> states,
  ) {
    if (states.any((state) => state.hasValue)) {
      return ApiConnectionStatus.online;
    }

    if (states.any((state) => state.isLoading)) {
      return ApiConnectionStatus.checking;
    }

    return ApiConnectionStatus.offline;
  }

  @override
  Widget build(BuildContext context) {
    final reviewState = ref.watch(pendingReviewOrdersProvider);
    final readyState = ref.watch(readyToConfirmOrdersProvider);
    final inProgressState = ref.watch(inProgressOrdersProvider);
    final reviewOrders = reviewState.valueOrNull;
    final readyOrders = readyState.valueOrNull;
    final inProgressOrders = inProgressState.valueOrNull;
    final pendingCount =
        (reviewOrders?.length ?? 0) +
        (readyOrders?.length ?? 0) +
        (inProgressOrders?.length ?? 0);
    final realtimeStatus = _webSocketService.status;
    final apiStatus = _apiConnectionStatus([
      reviewState,
      readyState,
      inProgressState,
    ]);
    final isFullyOffline =
        apiStatus == ApiConnectionStatus.offline &&
        realtimeStatus == RealtimeConnectionStatus.disconnected;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kasir - Arpul'),
          actions: [
            ConnectionIndicator(
              realtimeStatus: realtimeStatus,
              apiStatus: apiStatus,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: _PendingCounter(count: pendingCount),
            ),
            IconButton(
              tooltip: 'Logout',
              onPressed: () => ref.read(authStateProvider.notifier).logout(),
              icon: const Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Cek Bukti'),
              Tab(text: 'Konfirmasi'),
              Tab(text: 'Diproses'),
              Tab(text: 'POS'),
            ],
          ),
        ),
        body: Column(
          children: [
            if (isFullyOffline) const _OfflineBanner(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _KasirMetricCard(
                      label: 'Cek bukti',
                      value: '${reviewOrders?.length ?? 0}',
                      icon: Icons.verified_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _KasirMetricCard(
                      label: 'Konfirmasi',
                      value: '${readyOrders?.length ?? 0}',
                      icon: Icons.receipt_long,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _KasirMetricCard(
                      label: 'Diproses',
                      value: '${inProgressOrders?.length ?? 0}',
                      icon: Icons.local_shipping_outlined,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _OrderListTab(
                    state: reviewState,
                    mode: OrderCardMode.review,
                    emptyTitle: 'Belum ada bukti pembayaran',
                    emptySubtitle:
                        'Order QRIS yang sudah upload bukti akan muncul di sini.',
                    onRefresh: () =>
                        ref.read(pendingReviewOrdersProvider.notifier).fetch(),
                  ),
                  _OrderListTab(
                    state: readyState,
                    mode: OrderCardMode.confirm,
                    emptyTitle: 'Belum ada order siap konfirmasi',
                    emptySubtitle:
                        'Order yang pembayarannya sudah verified akan muncul di sini.',
                    onRefresh: () =>
                        ref.read(readyToConfirmOrdersProvider.notifier).fetch(),
                  ),
                  _OrderListTab(
                    state: inProgressState,
                    mode: OrderCardMode.inProgress,
                    emptyTitle: 'Tidak ada order diproses',
                    emptySubtitle:
                        'Order yang sudah dikonfirmasi akan muncul di sini.',
                    onRefresh: () =>
                        ref.read(inProgressOrdersProvider.notifier).fetch(),
                  ),
                  const PosTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderListTab extends StatelessWidget {
  const _OrderListTab({
    required this.state,
    required this.mode,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.onRefresh,
  });

  final AsyncValue<List<OrderModel>> state;
  final OrderCardMode mode;
  final String emptyTitle;
  final String emptySubtitle;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: state.when(
        loading: () => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, __) => const LoadingWidget.listTile(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: 6,
        ),
        error: (error, _) => AppErrorWidget(error: error, onRetry: onRefresh),
        data: (orders) {
          if (orders.isEmpty) {
            return ListView(
              children: [
                const SizedBox(height: 120),
                EmptyStateWidget(
                  icon: Icons.receipt_long_outlined,
                  title: emptyTitle,
                  subtitle: emptySubtitle,
                ),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) =>
                OrderCard(order: orders[index], mode: mode),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: orders.length,
          );
        },
      ),
    );
  }
}

class _PosTab extends ConsumerStatefulWidget {
  const _PosTab();

  @override
  ConsumerState<_PosTab> createState() => _PosTabState();
}

class _PosTabState extends ConsumerState<_PosTab> {
  final _paidController = TextEditingController();
  final _tableController = TextEditingController();
  final Map<int, int> _cart = {};
  bool _isSubmitting = false;

  @override
  void dispose() {
    _paidController.dispose();
    _tableController.dispose();
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
        itemCount: 4,
      ),
      error: (error, _) => AppErrorWidget(
        error: error,
        onRetry: () => ref.invalidate(posProductsProvider),
      ),
      data: (products) => _buildPos(context, products),
    );
  }

  Widget _buildPos(BuildContext context, List<ProductModel> products) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final productMap = {for (final product in products) product.id: product};
    final total = _cart.entries.fold<double>(0, (sum, entry) {
      return sum + ((productMap[entry.key]?.price ?? 0) * entry.value);
    });
    final paid = double.tryParse(_paidController.text) ?? 0;
    final change = paid - total;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('POS Offline', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        TextField(
          controller: _tableController,
          decoration: const InputDecoration(
            labelText: 'Nomor meja',
            prefixIcon: Icon(Icons.table_restaurant_outlined),
          ),
        ),
        const SizedBox(height: 16),
        ...products.map((product) {
          final qty = _cart[product.id] ?? 0;
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text(
                '${product.category} • ${currency.format(product.price)} • Stok ${product.stock}',
              ),
              trailing: SizedBox(
                width: 112,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: qty == 0
                          ? null
                          : () => setState(() {
                              if (qty <= 1) {
                                _cart.remove(product.id);
                              } else {
                                _cart[product.id] = qty - 1;
                              }
                            }),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$qty'),
                    IconButton(
                      onPressed: qty >= product.stock
                          ? null
                          : () => setState(() => _cart[product.id] = qty + 1),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SummaryRow(label: 'Total', value: currency.format(total)),
                const SizedBox(height: 10),
                TextField(
                  controller: _paidController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Uang dibayar',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 10),
                _SummaryRow(
                  label: 'Kembalian',
                  value: currency.format(change < 0 ? 0 : change),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: _cart.isEmpty || paid < total || _isSubmitting
                      ? null
                      : () => _submitPos(total),
                  icon: const Icon(Icons.point_of_sale),
                  label: Text(_isSubmitting ? 'Memproses...' : 'Bayar'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submitPos(double total) async {
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
        paidAmount: double.parse(_paidController.text),
        tableNumber: _tableController.text.trim(),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _cart.clear();
        _paidController.clear();
        _tableController.clear();
      });
      ref.invalidate(posProductsProvider);

      final currency = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaksi #${result.transaction.id} berhasil. Kembalian ${currency.format(result.change)}',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      final message = error is AppException
          ? error.message
          : 'Transaksi POS gagal.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
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

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.wifi_off, color: colorScheme.onErrorContainer),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'API dan realtime belum tersambung',
                style: TextStyle(
                  color: colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KasirMetricCard extends StatelessWidget {
  const _KasirMetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primary, size: 20),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingCounter extends StatelessWidget {
  const _PendingCounter({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.notifications_outlined),
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
