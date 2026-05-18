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
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label ?? _defaultLabel(status),
          style: TextStyle(
            color: _foregroundColor(badgeColor),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Color _backgroundColor(String status) {
    return switch (status) {
      'pending' => const Color(0xFFF59E0B),
      'confirmed' => const Color(0xFF2563EB),
      'completed' => const Color(0xFF16A34A),
      'cancelled' || 'canceled' => const Color(0xFFDC2626),
      _ => const Color(0xFF6B7280),
    };
  }

  Color _foregroundColor(Color backgroundColor) {
    return ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.dark
        ? Colors.white
        : Colors.black;
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
