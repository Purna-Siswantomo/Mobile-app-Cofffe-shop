import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../features/kasir/data/models/order_model.dart';
import '../../features/kasir/presentation/providers/order_provider.dart';
import '../constants/pusher_constants.dart';

enum RealtimeConnectionStatus { connecting, connected, disconnected }

class PusherService extends ChangeNotifier {
  factory PusherService() => _instance;

  PusherService._();

  factory PusherService.mock() => PusherService._mock();

  PusherService._mock() {
    _isMock = true;
  }

  static final PusherService _instance = PusherService._();

  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  RealtimeConnectionStatus _status = RealtimeConnectionStatus.disconnected;
  Timer? _mockTimer;
  bool _isInitialized = false;
  bool _isMock = false;

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
      await _pusher.init(
        apiKey: PusherConstants.kPusherAppKey,
        cluster: PusherConstants.kPusherCluster,
        onConnectionStateChange: (currentState, previousState) {
          log(
            'Pusher connection state: $previousState -> $currentState',
            name: 'PusherService',
          );
          _setStatus(_mapConnectionStatus(currentState));
        },
        onError: (message, code, error) {
          log(
            'Pusher error: $message code=$code error=$error',
            name: 'PusherService',
          );
          _setStatus(RealtimeConnectionStatus.disconnected);
        },
        onEvent: (event) => _handleEvent(event, ref),
      );

      await _pusher.subscribe(channelName: PusherConstants.kOrderChannel);
      await _pusher.connect();
    } catch (error, stackTrace) {
      log(
        'Pusher init failed',
        name: 'PusherService',
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

    if (_isMock) {
      _setStatus(RealtimeConnectionStatus.disconnected);
      return;
    }

    try {
      await _pusher.unsubscribe(channelName: PusherConstants.kOrderChannel);
      await _pusher.disconnect();
    } catch (error, stackTrace) {
      log(
        'Pusher disconnect failed',
        name: 'PusherService',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _setStatus(RealtimeConnectionStatus.disconnected);
    }
  }

  void _handleEvent(PusherEvent event, WidgetRef ref) {
    if (event.channelName != PusherConstants.kOrderChannel) {
      return;
    }

    try {
      switch (event.eventName) {
        case PusherConstants.kNewOrderEvent:
          final order = OrderModel.fromJson(_payloadAsMap(event.data));
          ref.read(pendingOrdersProvider.notifier).addNewOrder(order);
        case PusherConstants.kOrderStatusEvent:
          ref.invalidate(pendingOrdersProvider);
      }
    } catch (error, stackTrace) {
      log(
        'Failed to handle Pusher event ${event.eventName}',
        name: 'PusherService',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Map<String, dynamic> _payloadAsMap(dynamic payload) {
    final decoded = payload is String ? jsonDecode(payload) : payload;
    if (decoded is Map<String, dynamic>) {
      final data = decoded['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }

      return decoded;
    }

    if (decoded is Map) {
      final data = decoded['data'];
      final map = data is Map ? data : decoded;
      return map.map((key, value) => MapEntry(key.toString(), value));
    }

    return <String, dynamic>{};
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

  RealtimeConnectionStatus _mapConnectionStatus(String state) {
    return switch (state.toLowerCase()) {
      'connected' => RealtimeConnectionStatus.connected,
      'connecting' || 'reconnecting' => RealtimeConnectionStatus.connecting,
      _ => RealtimeConnectionStatus.disconnected,
    };
  }

  void _setStatus(RealtimeConnectionStatus status) {
    if (_status == status) {
      return;
    }

    _status = status;
    notifyListeners();
  }
}
