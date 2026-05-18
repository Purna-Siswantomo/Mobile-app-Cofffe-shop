const String kAppName = AppConstants.kAppName;
const String kTokenKey = AppConstants.kTokenKey;
const String kUserKey = AppConstants.kUserKey;
const String kRoleAdmin = AppConstants.kRoleAdmin;
const String kRoleKasir = AppConstants.kRoleKasir;
const Duration kConnectTimeout = AppConstants.kConnectTimeout;
const Duration kReceiveTimeout = AppConstants.kReceiveTimeout;

class AppConstants {
  static const String kAppName = 'Arpul';
  static const String kTokenKey = 'sanctum_token';
  static const String kUserKey = 'user_data';
  static const String kRoleAdmin = 'admin';
  static const String kRoleKasir = 'kasir';
  static const Duration kConnectTimeout = Duration(seconds: 15);
  static const Duration kReceiveTimeout = Duration(seconds: 15);
}
