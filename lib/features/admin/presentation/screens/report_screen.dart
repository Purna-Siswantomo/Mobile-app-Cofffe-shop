import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../shared/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../providers/transaction_provider.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsState = ref.watch(transactionsProvider);
    final filter = ref.watch(transactionFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(transactionsProvider),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ReportFilterBar(filter: filter),
            const SizedBox(height: 12),
            transactionsState.when(
              loading: () => Column(
                children: List.generate(
                  6,
                  (index) => const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: LoadingWidget.listTile(),
                  ),
                ),
              ),
              error: (error, _) => AppErrorWidget(
                error: error,
                onRetry: () => ref.invalidate(transactionsProvider),
              ),
              data: (transactions) {
                if (transactions.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.bar_chart_outlined,
                    title: 'Belum ada transaksi',
                    subtitle: filter.hasActiveFilter
                        ? 'Tidak ada transaksi yang cocok dengan filter.'
                        : 'Transaksi yang tercatat akan tampil di sini.',
                  );
                }

                final total = transactions.fold<double>(
                  0,
                  (sum, item) => sum + item.displayTotal,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Expanded(
                              child: _SummaryMetric(
                                label: 'Transaksi',
                                value: '${transactions.length}',
                              ),
                            ),
                            Expanded(
                              child: _SummaryMetric(
                                label: 'Total',
                                value: CurrencyFormatter.formatRupiah(total),
                                alignEnd: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...transactions.map(
                      (transaction) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () =>
                                context.go('/admin/reports/${transaction.id}'),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Transaksi #${transaction.id}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                      ),
                                      StatusBadge(
                                        status: transaction.status,
                                        label: transaction.statusLabel,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    CurrencyFormatter.formatRupiah(
                                      transaction.displayTotal,
                                    ),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _formatCreatedAt(transaction.createdAt),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    [
                                      transaction.orderTypeLabel,
                                      transaction.paymentMethod ?? '-',
                                      '${transaction.itemCount} item',
                                    ].join(' - '),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatCreatedAt(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) {
      return value;
    }

    return DateFormat('d MMM yyyy, HH:mm', 'id_ID').format(date.toLocal());
  }
}

class _ReportFilterBar extends ConsumerWidget {
  const _ReportFilterBar({required this.filter});

  final TransactionFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterNotifier = ref.read(transactionFilterProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: filter.status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      prefixIcon: Icon(Icons.filter_alt_outlined),
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Semua status'),
                      ),
                      ...allTransactionStatuses.map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(_statusLabel(status)),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      filterNotifier.state = filter.copyWith(status: value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickDateRange(context, ref),
                    icon: const Icon(Icons.date_range_outlined),
                    label: Text(_dateRangeLabel(filter)),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Reset filter',
                  onPressed: filter.hasActiveFilter
                      ? () => filterNotifier.state = const TransactionFilter()
                      : null,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateRange(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final current = ref.read(transactionFilterProvider);
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 3),
      lastDate: DateTime(now.year + 1),
      initialDateRange: current.fromDate != null && current.toDate != null
          ? DateTimeRange(start: current.fromDate!, end: current.toDate!)
          : null,
    );

    if (picked == null) {
      return;
    }

    ref.read(transactionFilterProvider.notifier).state = current.copyWith(
      fromDate: picked.start,
      toDate: picked.end,
      date: null,
    );
  }

  String _dateRangeLabel(TransactionFilter filter) {
    if (filter.fromDate == null || filter.toDate == null) {
      return 'Pilih tanggal';
    }

    final formatter = DateFormat('d MMM yyyy', 'id_ID');

    return '${formatter.format(filter.fromDate!)} - ${formatter.format(filter.toDate!)}';
  }

  String _statusLabel(String status) {
    return switch (status) {
      'pending' => 'Menunggu',
      'in_progress' => 'Diproses',
      'delivering' => 'Diantar',
      'completed' => 'Selesai',
      'paid' => 'Dibayar',
      'canceled' => 'Dibatalkan',
      _ => status,
    };
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
