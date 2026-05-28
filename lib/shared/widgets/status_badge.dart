import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.label});

  final String status;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final badgeColor = _backgroundColor(status);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: badgeColor,
        border: Border.all(color: _borderColor(status)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label ?? _defaultLabel(status),
          style: TextStyle(
            color: _foregroundColor(status),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _backgroundColor(String status) {
    return switch (status) {
      'pending' => const Color(0xFFFFF4D8),
      'confirmed' || 'in_progress' => const Color(0xFFDAE2FD),
      'delivering' => const Color(0xFFE5EEFF),
      'completed' || 'paid' => const Color(0xFFA6F2D1),
      'cancelled' || 'canceled' || 'rejected' => const Color(0xFFFFDAD6),
      _ => const Color(0xFFEFF4FF),
    };
  }

  Color _foregroundColor(String status) {
    return switch (status) {
      'pending' => const Color(0xFF7A4D00),
      'confirmed' || 'in_progress' => const Color(0xFF3F465C),
      'delivering' => const Color(0xFF004532),
      'completed' || 'paid' => const Color(0xFF00513B),
      'cancelled' || 'canceled' || 'rejected' => const Color(0xFF93000A),
      _ => const Color(0xFF3F4944),
    };
  }

  Color _borderColor(String status) {
    return _foregroundColor(status).withValues(alpha: 0.18);
  }

  String _defaultLabel(String status) {
    return switch (status) {
      'pending' => 'Menunggu',
      'confirmed' => 'Dikonfirmasi',
      'completed' => 'Selesai',
      'cancelled' || 'canceled' => 'Dibatalkan',
      _ => status,
    };
  }
}
