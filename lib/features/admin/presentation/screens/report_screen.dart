import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(transactionsProvider),
        child: transactionsState.when(
          loading: () => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, __) => const LoadingWidget.listTile(),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: 6,
          ),
          error: (error, _) => AppErrorWidget(
            error: error,
            onRetry: () => ref.invalidate(transactionsProvider),
          ),
          data: (transactions) {
            if (transactions.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  EmptyStateWidget(
                    icon: Icons.bar_chart_outlined,
                    title: 'Belum ada transaksi',
                    subtitle: 'Transaksi yang tercatat akan tampil di sini.',
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return Card(
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
                                style: Theme.of(context).textTheme.titleMedium,
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
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _formatCreatedAt(transaction.createdAt),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (transaction.paymentMethod != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Pembayaran: ${transaction.paymentMethod}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: transactions.length,
            );
          },
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
