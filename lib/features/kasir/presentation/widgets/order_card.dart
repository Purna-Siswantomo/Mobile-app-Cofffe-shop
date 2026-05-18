import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../data/models/order_model.dart';
import '../providers/order_provider.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.go('/kasir/orders/${order.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order #${order.id}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  StatusBadge(status: order.status, label: order.statusLabel),
                ],
              ),
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.payments_outlined,
                text: currency.format(order.totalAmount),
              ),
              const SizedBox(height: 6),
              _InfoRow(
                icon: Icons.shopping_bag_outlined,
                text: '${order.resolvedItemCount} item',
              ),
              const SizedBox(height: 6),
              _InfoRow(
                icon: Icons.schedule,
                text: _formatCreatedAt(order.createdAt),
              ),
              if (order.status == 'pending') ...[
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _confirmCancel(context, ref),
                        child: const Text('Batalkan'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _confirmAccept(context, ref),
                        child: const Text('Konfirmasi'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmAccept(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showConfirmationDialog(
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
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showConfirmationDialog(
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
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<bool> _showConfirmationDialog(
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
