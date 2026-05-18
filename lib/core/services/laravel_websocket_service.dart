import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../features/kasir/data/models/order_model.dart';
import '../../features/kasir/presentation/providers/order_provider.dart';
import '../constants/websocket_constants.dart';

enum RealtimeConnectionStatus { connecting, connected, disconnected }

class LaravelWebSocketService extends ChangeNotifier {
  factory LaravelWebSocketService() => _instance;

  LaravelWebSocketService._();

  factory LaravelWebSocketService.mock() => LaravelWebSocketService._mock();

  LaravelWebSocketService._mock() {
    _isMock = true;
  }

  static final LaravelWebSocketService _instance = LaravelWebSocketService._();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  Timer? _mockTimer;
  bool _isInitialized = false;
  bool _isMock = false;
  RealtimeConnectionStatus _status = RealtimeConnectionStatus.disconnected;

  RealtimeConnectionStatus get status => _status;

  bool get isConnected => _status == RealtimeConnectionStatus.connected;

  Future<void> init(WidgetRef ref) async {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;
    _setStatus(RealtimeConnectionStatus.connecting);

    if (_isMock) {
      _startMockOrders(ref);
      return;
    }

    try {
      final channel = WebSocketChannel.connect(WebSocketConstants.socketUri);
      _channel = channel;
      _subscription = channel.stream.listen(
        (message) => _handleMessage(message, ref),
        onError: (Object error, StackTrace stackTrace) {
          log(
            'Laravel WebSocket error',
            name: 'LaravelWebSocketService',
            error: error,
            stackTrace: stackTrace,
          );
          _setStatus(RealtimeConnectionStatus.disconnected);
        },
        onDone: () {
          log(
            'Laravel WebSocket disconnected',
            name: 'LaravelWebSocketService',
          );
          _setStatus(RealtimeConnectionStatus.disconnected);
        },
        cancelOnError: false,
      );

      log(
        'Connecting to ${WebSocketConstants.socketUri}',
        name: 'LaravelWebSocketService',
      );
    } catch (error, stackTrace) {
      log(
        'Laravel WebSocket init failed',
        name: 'LaravelWebSocketService',
        error: error,
        stackTrace: stackTrace,
      );
      _setStatus(RealtimeConnectionStatus.disconnected);
    }
  }

  Future<void> disconnect() async {
    _mockTimer?.cancel();
    _mockTimer = null;
    _isInitialized = false;

    await _subscription?.cancel();
    _subscription = null;

    await _channel?.sink.close();
    _channel = null;

    _setStatus(RealtimeConnectionStatus.disconnected);
  }

  void _handleMessage(dynamic message, WidgetRef ref) {
    try {
      final payload = _decodeMessage(message);
      final event = payload['event']?.toString();

      if (event == 'pusher:connection_established') {
        _setStatus(RealtimeConnectionStatus.connected);
        _subscribeToOrders();
        return;
      }

      if (event == 'pusher_internal:subscription_succeeded' ||
          event == 'pusher:subscription_succeeded') {
        log('Subscribed to orders channel', name: 'LaravelWebSocketService');
        return;
      }

      if (!_isOrderChannel(payload)) {
        return;
      }

      final normalizedEvent = event?.replaceFirst('.', '');
      switch (normalizedEvent) {
        case WebSocketConstants.kNewOrderEvent:
          final order = OrderModel.fromJson(_eventDataAsMap(payload['data']));
          ref.read(pendingOrdersProvider.notifier).addNewOrder(order);
        case WebSocketConstants.kOrderStatusEvent:
          ref.invalidate(pendingOrdersProvider);
      }
    } catch (error, stackTrace) {
      log(
        'Failed to handle Laravel WebSocket message',
        name: 'LaravelWebSocketService',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Map<String, dynamic> _decodeMessage(dynamic message) {
    final decoded = message is String ? jsonDecode(message) : message;
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }

    return <String, dynamic>{};
  }

  bool _isOrderChannel(Map<String, dynamic> payload) {
    return payload['channel'] == WebSocketConstants.kOrderChannel;
  }

  Map<String, dynamic> _eventDataAsMap(dynamic data) {
    final decoded = data is String ? jsonDecode(data) : data;
    if (decoded is Map<String, dynamic>) {
      final nestedData = decoded['data'];
      if (nestedData is Map<String, dynamic>) {
        return nestedData;
      }

      return decoded;
    }
    if (decoded is Map) {
      final nestedData = decoded['data'];
      final map = nestedData is Map ? nestedData : decoded;
      return map.map((key, value) => MapEntry(key.toString(), value));
    }

    return <String, dynamic>{};
  }

  void _subscribeToOrders() {
    _channel?.sink.add(
      jsonEncode({
        'event': 'pusher:subscribe',
        'data': {'channel': WebSocketConstants.kOrderChannel},
      }),
    );
  }

  void _startMockOrders(WidgetRef ref) {
    _setStatus(RealtimeConnectionStatus.connected);
    _mockTimer?.cancel();
    _mockTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      final now = DateTime.now();
      final order = OrderModel(
        id: now.millisecondsSinceEpoch,
        userId: null,
        totalAmount: 25000 + (now.second * 1000),
        status: 'pending',
        paymentMethod: 'cash',
        createdAt: now.toIso8601String(),
        itemCount: 1 + (now.second % 4),
      );

      ref.read(pendingOrdersProvider.notifier).addNewOrder(order);
    });
  }

  void _setStatus(RealtimeConnectionStatus status) {
    if (_status == status) {
      return;
    }

    _status = status;
    notifyListeners();
  }
}
