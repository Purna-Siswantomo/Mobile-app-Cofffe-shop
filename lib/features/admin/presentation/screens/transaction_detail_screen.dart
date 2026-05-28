import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../shared/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../../kasir/data/models/order_model.dart';
import '../../data/models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({super.key, required this.transactionId});

  final int? transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = transactionId;
    final transactionState = id == null
        ? const AsyncValue<TransactionModel?>.data(null)
        : ref
              .watch(transactionDetailProvider(id))
              .whenData<TransactionModel?>((transaction) => transaction);

    return Scaffold(
      appBar: AppBar(title: Text('Transaksi #${transactionId ?? '-'}')),
      body: transactionState.when(
        loading: () => ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            LoadingWidget.card(),
            SizedBox(height: 12),
            LoadingWidget.listTile(),
            LoadingWidget.listTile(),
          ],
        ),
        error: (error, _) => AppErrorWidget(
          error: error,
          onRetry: () {
            if (id != null) {
              ref.invalidate(transactionDetailProvider(id));
            }
          },
        ),
        data: (transaction) {
          if (transaction == null) {
            return const EmptyStateWidget(
              icon: Icons.search_off_outlined,
              title: 'Transaksi tidak ditemukan',
              subtitle: 'Transaksi mungkin sudah dihapus atau tidak tersedia.',
            );
          }

          return _TransactionDetailContent(transaction: transaction);
        },
      ),
    );
  }
}

class _TransactionDetailContent extends StatelessWidget {
  const _TransactionDetailContent({required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Transaksi #${transaction.id}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    StatusBadge(
                      status: transaction.status,
                      label: transaction.statusLabel,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  label: 'Total',
                  value: CurrencyFormatter.formatRupiah(
                    transaction.displayTotal,
                  ),
                ),
                _DetailRow(
                  label: 'Dibayar',
                  value: CurrencyFormatter.formatRupiah(
                    transaction.displayPaidAmount,
                  ),
                ),
                _DetailRow(
                  label: 'Pembayaran',
                  value: transaction.paymentMethod ?? '-',
                ),
                _DetailRow(
                  label: 'Status bayar',
                  value: transaction.paymentStatusLabel,
                ),
                _DetailRow(label: 'Tipe', value: transaction.orderTypeLabel),
                if (transaction.tableNumber != null)
                  _DetailRow(label: 'Meja', value: transaction.tableNumber!),
                if (transaction.user?.name != null)
                  _DetailRow(label: 'Customer', value: transaction.user!.name),
                if (transaction.notes != null)
                  _DetailRow(label: 'Catatan', value: transaction.notes!),
                _DetailRow(
                  label: 'Waktu',
                  value: _formatCreatedAt(transaction.createdAt),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Item Pesanan', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (transaction.details.isEmpty)
          const EmptyStateWidget(
            icon: Icons.receipt_outlined,
            title: 'Item tidak tersedia',
            subtitle: 'Backend tidak mengirim detail item untuk transaksi ini.',
          )
        else
          ...transaction.details.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _TransactionItemTile(item: item),
            ),
          ),
      ],
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

class _TransactionItemTile extends StatelessWidget {
  const _TransactionItemTile({required this.item});

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.quantity} x ${CurrencyFormatter.formatRupiah(item.unitPrice)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              CurrencyFormatter.formatRupiah(item.subtotal),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
