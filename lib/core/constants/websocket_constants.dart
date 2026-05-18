const String kWebSocketAppKey = WebSocketConstants.kWebSocketAppKey;
const String kWebSocketHost = WebSocketConstants.kWebSocketHost;
const int kWebSocketPort = WebSocketConstants.kWebSocketPort;
const String kOrderChannel = WebSocketConstants.kOrderChannel;
const String kNewOrderEvent = WebSocketConstants.kNewOrderEvent;
const String kOrderStatusEvent = WebSocketConstants.kOrderStatusEvent;

class WebSocketConstants {
  static const String kWebSocketAppKey = String.fromEnvironment(
    'LARAVEL_WS_APP_KEY',
    defaultValue: 'arpul-local-key',
  );
  static const String kWebSocketHost = String.fromEnvironment(
    'LARAVEL_WS_HOST',
    defaultValue: '10.0.2.2',
  );
  static const int kWebSocketPort = int.fromEnvironment(
    'LARAVEL_WS_PORT',
    defaultValue: 6001,
  );
  static const bool kWebSocketUseTls = bool.fromEnvironment(
    'LARAVEL_WS_TLS',
    defaultValue: false,
  );
  static const String kOrderChannel = 'orders';
  static const String kNewOrderEvent = 'new-order';
  static const String kOrderStatusEvent = 'order-status-updated';

  static Uri get socketUri {
    const scheme = kWebSocketUseTls ? 'wss' : 'ws';

    return Uri(
      scheme: scheme,
      host: kWebSocketHost,
      port: kWebSocketPort,
      path: '/app/$kWebSocketAppKey',
      queryParameters: const {
        'protocol': '7',
        'client': 'flutter',
        'version': '1.0.0',
        'flash': 'false',
      },
    );
  }
}
