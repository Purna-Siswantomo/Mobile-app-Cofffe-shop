const String kBaseUrl = ApiConstants.kBaseUrl;
const String kBaseUrlProd = ApiConstants.kBaseUrlProd;

class ApiConstants {
  static const String kBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8001/api/v1',
  );
  static const String kBaseUrlProd = String.fromEnvironment(
    'API_BASE_URL_PROD',
    defaultValue: kBaseUrl,
  );
}

class ApiEndpoints {
  static const String kLogin = '/auth/login';
  static const String kLogout = '/auth/logout';
  static const String kMe = '/auth/me';
  static const String kDashboard = '/dashboard';
  static const String kProducts = '/products';
  static const String kProductCategories = '/products/categories';
  static const String kTransactions = '/transactions';
  static const String kReportsSummary = '/reports/summary';
  static const String kReportsExport = '/reports/export';
  static const String kUsers = '/users';
  static const String kNotifications = '/notifications';
  static const String kNotificationsBroadcast = '/notifications/broadcast';
  static const String kDeliverySettings = '/settings/delivery';
  static const String kProfile = '/profile';
  static const String kOrdersPending = '/orders/pending';
  static const String kOrdersPendingReview = '/orders/pending-review';
  static const String kOrdersReadyToConfirm = '/orders/ready-to-confirm';
  static const String kOrdersInProgress = '/orders/in-progress';
  static const String kOrderDetail = '/orders/{id}';
  static const String kOrderVerifyPayment = '/orders/{id}/payment/verify';
  static const String kOrderRejectPayment = '/orders/{id}/payment/reject';
  static const String kOrderConfirm = '/orders/{id}/confirm';
  static const String kOrderDeliver = '/orders/{id}/deliver';
  static const String kOrderComplete = '/orders/{id}/complete';
  static const String kOrderCancel = '/orders/{id}/cancel';
  static const String kOrderUpdateStatus = '/transactions/{id}/status';
  static const String kPosProducts = '/pos/products';
  static const String kPosTransactions = '/pos/transactions';
}
