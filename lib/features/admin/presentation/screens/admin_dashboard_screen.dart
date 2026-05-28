import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/theme/app_theme.dart';
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
            Text(
              'Ringkasan Hari Ini',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Pantau operasional, produk, transaksi, dan pengaturan toko.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            statsState.when(
              loading: () => const _StatsLoadingGrid(),
              error: (error, _) => AppErrorWidget(
                error: error,
                onRetry: () => ref.invalidate(dashboardStatsProvider),
              ),
              data: (stats) => LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 720 ? 4 : 2;

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: constraints.maxWidth >= 720 ? 1.15 : 1.05,
                    children: [
                      _StatCard(
                        title: 'Transaksi',
                        value: '${stats.totalTransaksiHariIni}',
                        icon: Icons.receipt_long,
                        color: AppTheme.primary,
                        surface: AppTheme.surfaceLow,
                      ),
                      _StatCard(
                        title: 'Revenue',
                        value: CurrencyFormatter.formatRupiah(
                          stats.totalRevenueHariIni,
                        ),
                        icon: Icons.payments_outlined,
                        color: AppTheme.tertiary,
                        surface: AppTheme.tertiaryContainer,
                      ),
                      _StatCard(
                        title: 'Produk',
                        value: '${stats.totalProduk}',
                        icon: Icons.inventory_2_outlined,
                        color: AppTheme.secondary,
                        surface: AppTheme.secondaryContainer,
                      ),
                      _StatCard(
                        title: 'Pending',
                        value: '${stats.orderPending}',
                        icon: Icons.pending_actions,
                        color: const Color(0xFF7A4D00),
                        surface: const Color(0xFFFFF4D8),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Menu Admin', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _AdminMenuTile(
              title: 'Produk',
              subtitle: 'Kelola katalog, harga, stok, dan gambar produk.',
              icon: Icons.inventory_2_outlined,
              onTap: () => context.go('/admin/products'),
            ),
            const SizedBox(height: 10),
            _AdminMenuTile(
              title: 'Laporan',
              subtitle: 'Pantau transaksi, filter periode, dan lihat detail.',
              icon: Icons.bar_chart_outlined,
              onTap: () => context.go('/admin/reports'),
            ),
            const SizedBox(height: 10),
            _AdminMenuTile(
              title: 'Manajemen',
              subtitle: 'Atur user, notifikasi, delivery, dan summary report.',
              icon: Icons.admin_panel_settings_outlined,
              onTap: () => context.go('/admin/management'),
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
    required this.surface,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color surface;

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
                color: surface,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
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

class _AdminMenuTile extends StatelessWidget {
  const _AdminMenuTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceLow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(icon, color: AppTheme.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
