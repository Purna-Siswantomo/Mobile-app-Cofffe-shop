import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/widgets/dialog_action_row.dart';
import '../../../../shared/widgets/payment_proof_viewer.dart';
import '../../../../shared/widgets/reason_dialog.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../data/models/order_model.dart';
import '../providers/order_provider.dart';

enum OrderCardMode { review, confirm, inProgress, readonly }

class OrderCard extends ConsumerWidget {
  const OrderCard({
    super.key,
    required this.order,
    this.mode = OrderCardMode.confirm,
  });

  final OrderModel order;
  final OrderCardMode mode;

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
        onTap: () => context.push('/kasir/orders/${order.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order #${order.id} • ${order.orderTypeLabel}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  StatusBadge(status: order.status, label: order.statusLabel),
                ],
              ),
              const SizedBox(height: 10),
              if (order.user?.name != null) ...[
                _InfoRow(icon: Icons.person_outline, text: order.user!.name),
                const SizedBox(height: 6),
              ],
              if (order.tableNumber != null) ...[
                _InfoRow(
                  icon: Icons.table_restaurant_outlined,
                  text: 'Meja ${order.tableNumber}',
                ),
                const SizedBox(height: 6),
              ],
              if (order.delivery != null) ...[
                _InfoRow(
                  icon: Icons.local_shipping_outlined,
                  text:
                      '${order.delivery!.recipientName ?? '-'} • ${order.delivery!.phone ?? '-'}',
                ),
                const SizedBox(height: 6),
                _InfoRow(
                  icon: Icons.place_outlined,
                  text: order.delivery!.address ?? '-',
                ),
                const SizedBox(height: 6),
              ],
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
              const SizedBox(height: 6),
              _InfoRow(
                icon: Icons.verified_outlined,
                text: 'Pembayaran: ${order.paymentStatusLabel}',
              ),
              if (order.paymentProofUrl != null) ...[
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => _showPaymentProof(context),
                  icon: const Icon(Icons.image_outlined),
                  label: const Text('Lihat bukti pembayaran'),
                ),
              ],
              ..._buildActions(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, WidgetRef ref) {
    return switch (mode) {
      OrderCardMode.review => [
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _rejectPayment(context, ref),
                child: const Text('Tolak'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _verifyPayment(context, ref),
                child: const Text('Verifikasi'),
              ),
            ),
          ],
        ),
      ],
      OrderCardMode.confirm => [
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
      OrderCardMode.inProgress => [
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            if (order.canBeCanceledByKasir)
              OutlinedButton(
                onPressed: () => _cancelOrder(context, ref),
                child: const Text('Batalkan'),
              ),
            if (order.orderType == 'delivery' && order.status == 'in_progress')
              ElevatedButton(
                onPressed: () => _deliverOrder(context, ref),
                child: const Text('Diantar'),
              ),
            ElevatedButton(
              onPressed: () => _completeOrder(context, ref),
              child: const Text('Selesaikan'),
            ),
          ],
        ),
      ],
      OrderCardMode.readonly => const [],
    };
  }

  Future<void> _verifyPayment(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Verifikasi pembayaran?',
      message: 'Bukti pembayaran order #${order.id} akan disetujui.',
      confirmLabel: 'Verifikasi',
    );

    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref
          .read(pendingReviewOrdersProvider.notifier)
          .verifyPayment(order.id);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _rejectPayment(BuildContext context, WidgetRef ref) async {
    final reason = await _askReason(context, 'Alasan tolak pembayaran');
    if (reason == null || reason.isEmpty || !context.mounted) {
      return;
    }

    try {
      await ref
          .read(pendingReviewOrdersProvider.notifier)
          .rejectPayment(order.id, reason);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
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
      await ref
          .read(readyToConfirmOrdersProvider.notifier)
          .confirmOrder(order.id);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    await _cancelOrder(context, ref);
  }

  Future<void> _cancelOrder(BuildContext context, WidgetRef ref) async {
    final reason = await _askReason(context, 'Alasan pembatalan');
    if (reason == null || reason.isEmpty || !context.mounted) {
      return;
    }

    try {
      if (mode == OrderCardMode.confirm) {
        await ref
            .read(readyToConfirmOrdersProvider.notifier)
            .cancelOrder(order.id, reason);
      } else if (mode == OrderCardMode.inProgress) {
        await ref
            .read(inProgressOrdersProvider.notifier)
            .cancelOrder(order.id, reason);
      } else if (mode == OrderCardMode.review) {
        await ref
            .read(pendingReviewOrdersProvider.notifier)
            .cancelOrder(order.id, reason);
      } else {
        await ref.read(orderRepositoryProvider).cancelOrder(order.id, reason);
        ref.invalidate(pendingOrdersProvider);
        ref.invalidate(pendingReviewOrdersProvider);
        ref.invalidate(readyToConfirmOrdersProvider);
        ref.invalidate(inProgressOrdersProvider);
      }
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _deliverOrder(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(inProgressOrdersProvider.notifier).deliverOrder(order.id);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _completeOrder(BuildContext context, WidgetRef ref) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Selesaikan pesanan?',
      message: 'Order #${order.id} akan ditandai selesai.',
      confirmLabel: 'Selesaikan',
    );

    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref.read(inProgressOrdersProvider.notifier).completeOrder(order.id);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<String?> _askReason(BuildContext context, String title) async {
    return showDialog<String>(
      context: context,
      builder: (context) => ReasonDialog(title: title, confirmLabel: 'Simpan'),
    );
  }

  void _showPaymentProof(BuildContext context) {
    final url = order.paymentProofUrl;
    if (url == null) {
      return;
    }

    showPaymentProofViewer(context, imageUrl: url);
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
              DialogActionRow(
                cancelLabel: 'Kembali',
                confirmLabel: confirmLabel,
                isDestructive: isDestructive,
                onCancel: () => Navigator.of(context).pop(false),
                onConfirm: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showError(BuildContext context, Object error) {
    final message = switch (error) {
      ValidationException(:final errors) when errors.isNotEmpty =>
        errors.values.first.first,
      AppException(:final message) => message,
      _ => 'Aksi gagal. Silakan coba lagi.',
    };

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
