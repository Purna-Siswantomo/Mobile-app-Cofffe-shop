const String kBaseUrl = ApiConstants.kBaseUrl;
const String kBaseUrlProd = ApiConstants.kBaseUrlProd;

class ApiConstants {
  static const String kBaseUrl = 'http://10.0.2.2:8001/api/v1';
  static const String kBaseUrlProd = 'http://127.0.0.1:8001/api/v1';
}

class ApiEndpoints {
  static const String kLogin = '/auth/login';
  static const String kLogout = '/auth/logout';
  static const String kMe = '/auth/me';
  static const String kDashboard = '/dashboard';
  static const String kProducts = '/products';
  static const String kTransactions = '/transactions';
  static const String kOrdersPending = '/orders/pending';
  static const String kOrderConfirm = '/orders/{id}/confirm';
  static const String kOrderCancel = '/orders/{id}/cancel';
  static const String kOrderUpdateStatus = '/transactions/{id}/status';
}
