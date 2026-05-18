import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard - Arpul'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => ref.read(authStateProvider.notifier).logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardStatsProvider),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            statsState.when(
              loading: () => const _StatsLoadingGrid(),
              error: (error, _) => AppErrorWidget(
                error: error,
                onRetry: () => ref.invalidate(dashboardStatsProvider),
              ),
              data: (stats) => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
                children: [
                  _StatCard(
                    title: 'Transaksi hari ini',
                    value: '${stats.totalTransaksiHariIni}',
                    icon: Icons.receipt_long,
                    color: const Color(0xFF2563EB),
                  ),
                  _StatCard(
                    title: 'Revenue hari ini',
                    value: CurrencyFormatter.formatRupiah(
                      stats.totalRevenueHariIni,
                    ),
                    icon: Icons.payments_outlined,
                    color: const Color(0xFFE76F51),
                  ),
                  _StatCard(
                    title: 'Total produk',
                    value: '${stats.totalProduk}',
                    icon: Icons.inventory_2_outlined,
                    color: const Color(0xFF16A34A),
                  ),
                  _StatCard(
                    title: 'Order pending',
                    value: '${stats.orderPending}',
                    icon: Icons.pending_actions,
                    color: const Color(0xFFF59E0B),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () => context.go('/admin/products'),
              icon: const Icon(Icons.inventory_2_outlined),
              label: const Text('Kelola Produk'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => context.go('/admin/reports'),
              icon: const Icon(Icons.bar_chart_outlined),
              label: const Text('Lihat Reports'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsLoadingGrid extends StatelessWidget {
  const _StatsLoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: const [
        LoadingWidget.card(),
        LoadingWidget.card(),
        LoadingWidget.card(),
        LoadingWidget.card(),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: Icon(icon, color: color, size: 22),
              ),
            ),
            const Spacer(),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
