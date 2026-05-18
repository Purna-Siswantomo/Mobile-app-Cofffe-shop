import 'package:flutter/material.dart';

import '../../core/services/laravel_websocket_service.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({super.key, required this.status});

  final RealtimeConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Real-time: ${_label(status)}',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _color(status),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: const SizedBox(width: 12, height: 12),
        ),
      ),
    );
  }

  Color _color(RealtimeConnectionStatus status) {
    return switch (status) {
      RealtimeConnectionStatus.connected => Colors.green,
      RealtimeConnectionStatus.connecting => Colors.amber,
      RealtimeConnectionStatus.disconnected => Colors.red,
    };
  }

  String _label(RealtimeConnectionStatus status) {
    return switch (status) {
      RealtimeConnectionStatus.connected => 'connected',
      RealtimeConnectionStatus.connecting => 'connecting',
      RealtimeConnectionStatus.disconnected => 'disconnected',
    };
  }
}
