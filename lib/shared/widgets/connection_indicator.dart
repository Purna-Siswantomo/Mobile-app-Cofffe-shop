import 'package:flutter/material.dart';

import '../../core/services/laravel_websocket_service.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({
    super.key,
    required this.realtimeStatus,
    required this.apiStatus,
  });

  final RealtimeConnectionStatus realtimeStatus;
  final ApiConnectionStatus apiStatus;

  @override
  Widget build(BuildContext context) {
    final state = _state();
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: state.tooltip,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: state.color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: state.color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: state.color.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(state.icon, size: 14, color: state.color),
              ],
            ),
            const SizedBox(width: 6),
            Text(
              state.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ConnectionIndicatorState _state() {
    if (apiStatus == ApiConnectionStatus.online &&
        realtimeStatus == RealtimeConnectionStatus.connected) {
      return const _ConnectionIndicatorState(
        label: 'Online',
        tooltip: 'API aktif, realtime aktif',
        icon: Icons.cloud_done_outlined,
        color: Color(0xFF15803D),
      );
    }

    if (apiStatus == ApiConnectionStatus.online) {
      return const _ConnectionIndicatorState(
        label: 'API aktif',
        tooltip: 'API aktif. Realtime sedang tidak tersambung.',
        icon: Icons.cloud_sync_outlined,
        color: Color(0xFF0F766E),
      );
    }

    if (apiStatus == ApiConnectionStatus.checking ||
        realtimeStatus == RealtimeConnectionStatus.connecting) {
      return const _ConnectionIndicatorState(
        label: 'Cek koneksi',
        tooltip: 'Sedang mengecek koneksi API dan realtime',
        icon: Icons.sync_outlined,
        color: Color(0xFFD97706),
      );
    }

    return const _ConnectionIndicatorState(
      label: 'Offline',
      tooltip: 'API dan realtime belum tersambung',
      icon: Icons.cloud_off_outlined,
      color: Color(0xFFDC2626),
    );
  }
}

enum ApiConnectionStatus { checking, online, offline }

class _ConnectionIndicatorState {
  const _ConnectionIndicatorState({
    required this.label,
    required this.tooltip,
    required this.icon,
    required this.color,
  });

  final String label;
  final String tooltip;
  final IconData icon;
  final Color color;
}
