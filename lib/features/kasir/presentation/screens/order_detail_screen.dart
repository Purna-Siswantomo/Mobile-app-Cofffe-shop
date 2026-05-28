import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../data/models/order_model.dart';
import '../providers/order_provider.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final int? orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = orderId;
    final orderState = id == null
        ? const AsyncValue<OrderModel?>.data(null)
        : ref
              .watch(orderDetailProvider(id))
              .whenData<OrderModel?>((order) => order);

    return Scaffold(
      appBar: AppBar(title: Text('Order #${orderId ?? '-'}')),
      body: orderState.when(
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
              ref.invalidate(orderDetailProvider(id));
            }
          },
        ),
        data: (order) {
          if (order == null) {
            return const EmptyStateWidget(
              icon: Icons.search_off_outlined,
              title: 'Order tidak ditemukan',
              subtitle: 'Order mungkin sudah diproses atau tidak tersedia.',
            );
          }

          return _OrderDetailContent(order: order);
        },
      ),
    );
  }
}

class _OrderDetailContent extends ConsumerWidget {
  const _OrderDetailContent({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

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
                        'Order #${order.id}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    StatusBadge(status: order.status, label: order.statusLabel),
                  ],
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  label: 'Total',
                  value: currency.format(order.totalAmount),
                ),
                _DetailRow(
                  label: 'Jumlah item',
                  value: '${order.resolvedItemCount} item',
                ),
                _DetailRow(
                  label: 'Pembayaran',
                  value: order.paymentMethod ?? 'Belum dipilih',
                ),
                _DetailRow(
                  label: 'Status bayar',
                  value: order.paymentStatusLabel,
                ),
                _DetailRow(label: 'Tipe', value: order.orderTypeLabel),
                if (order.tableNumber != null)
                  _DetailRow(label: 'Meja', value: order.tableNumber!),
                if (order.user?.name != null)
                  _DetailRow(label: 'Customer', value: order.user!.name),
                if (order.notes != null)
                  _DetailRow(label: 'Catatan', value: order.notes!),
                _DetailRow(
                  label: 'Waktu masuk',
                  value: _formatCreatedAt(order.createdAt),
                ),
                if (order.delivery != null) ...[
                  const Divider(),
                  _DetailRow(
                    label: 'Penerima',
                    value: order.delivery!.recipientName ?? '-',
                  ),
                  _DetailRow(label: 'HP', value: order.delivery!.phone ?? '-'),
                  _DetailRow(
                    label: 'Alamat',
                    value: order.delivery!.address ?? '-',
                  ),
                ],
              ],
            ),
          ),
        ),
        if (order.paymentProofUrl != null) ...[
          const SizedBox(height: 16),
          Text(
            'Bukti Pembayaran',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              order.paymentProofUrl!,
              height: 240,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Bukti pembayaran gagal dimuat.'),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Text('Item Pesanan', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (order.details.isEmpty)
          const EmptyStateWidget(
            icon: Icons.receipt_outlined,
            title: 'Detail item belum tersedia',
            subtitle: 'Backend belum mengirim daftar item untuk order ini.',
          )
        else
          ...order.details.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _OrderItemTile(item: item, currency: currency),
            );
          }),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total keseluruhan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  currency.format(order.totalAmount),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        if (order.status == 'pending') ...[
          OutlinedButton(
            onPressed: () => _cancelOrder(context, ref),
            child: const Text('Batalkan'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _confirmOrder(context, ref),
            child: const Text('Konfirmasi'),
          ),
        ] else
          FilledButton.tonal(
            onPressed: null,
            child: Text('Status: ${order.statusLabel}'),
          ),
      ],
    );
  }

  Future<void> _confirmOrder(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showDialog(
      context,
      title: 'Konfirmasi pesanan?',
      message: 'Pesanan #${order.id} akan diterima dan diproses.',
      confirmLabel: 'Konfirmasi',
    );

    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref.read(pendingOrdersProvider.notifier).confirmOrder(order.id);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _cancelOrder(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showDialog(
      context,
      title: 'Batalkan pesanan?',
      message: 'Pesanan #${order.id} akan dibatalkan.',
      confirmLabel: 'Batalkan',
      isDestructive: true,
    );

    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref
          .read(pendingOrdersProvider.notifier)
          .cancelOrder(order.id, 'Dibatalkan oleh kasir');
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<bool> _showDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    bool isDestructive = false,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Kembali'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: isDestructive
                    ? ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError,
                      )
                    : null,
                child: Text(confirmLabel),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showError(BuildContext context, Object error) {
    final message = error is AppException
        ? error.message
        : 'Aksi gagal. Silakan coba lagi.';

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String _formatCreatedAt(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) {
      return value;
    }

    return DateFormat('d MMM yyyy, HH:mm', 'id_ID').format(date.toLocal());
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

class _OrderItemTile extends StatelessWidget {
  const _OrderItemTile({required this.item, required this.currency});

  final OrderItemModel item;
  final NumberFormat currency;

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
                    '${item.quantity} x ${currency.format(item.unitPrice)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              currency.format(item.subtotal),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
