import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/pusher_service.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/connection_indicator.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/order_provider.dart';
import '../widgets/order_card.dart';

class KasirDashboardScreen extends ConsumerStatefulWidget {
  const KasirDashboardScreen({super.key});

  @override
  ConsumerState<KasirDashboardScreen> createState() =>
      _KasirDashboardScreenState();
}

class _KasirDashboardScreenState extends ConsumerState<KasirDashboardScreen> {
  late final PusherService _pusherService;

  @override
  void initState() {
    super.initState();
    _pusherService = PusherService()..addListener(_onPusherStatusChanged);
    _pusherService.init(ref);
  }

  @override
  void dispose() {
    _pusherService
      ..removeListener(_onPusherStatusChanged)
      ..disconnect();
    super.dispose();
  }

  void _onPusherStatusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(pendingOrdersProvider);
    final pendingCount = ordersState.valueOrNull?.length ?? 0;
    final connectionStatus = _pusherService.status;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir - Arpul'),
        actions: [
          ConnectionIndicator(status: connectionStatus),
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
      ),
      body: Column(
        children: [
          if (connectionStatus == RealtimeConnectionStatus.disconnected)
            const _OfflineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(pendingOrdersProvider.notifier).fetchPending(),
              child: ordersState.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, __) => const LoadingWidget.listTile(),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: 6,
                ),
                error: (error, _) => AppErrorWidget(
                  error: error,
                  onRetry: () =>
                      ref.read(pendingOrdersProvider.notifier).fetchPending(),
                ),
                data: (orders) {
                  if (orders.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 120),
                        EmptyStateWidget(
                          icon: Icons.receipt_long_outlined,
                          title: 'Tidak ada pesanan masuk',
                          subtitle:
                              'Pesanan baru akan muncul otomatis di sini.',
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) =>
                        OrderCard(order: orders[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: orders.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
                'Mode offline',
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
