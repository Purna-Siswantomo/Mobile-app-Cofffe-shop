import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';

class AdminManagementRepository {
  AdminManagementRepository({Dio? dio, DioClient? dioClient})
    : _dio = dio ?? (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<AdminUsersResult> getUsers({
    String? search,
    String? role,
    String? status,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kUsers,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (role != null && role.isNotEmpty) 'role': role,
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );
      final data = _asMap(response.data?['data']);
      final users = _readPaginatorList(
        data['users'],
      ).map(AdminUser.fromJson).toList();

      return AdminUsersResult(users: users, stats: _asMap(data['stats']));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<AdminUser> createUser(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.kUsers,
        data: data,
      );

      return AdminUser.fromJson(_asMap(response.data?['data']));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<AdminUser> updateUser(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '${ApiEndpoints.kUsers}/$id',
        data: data,
      );

      return AdminUser.fromJson(_asMap(response.data?['data']));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<void> toggleUser(int id) async {
    try {
      await _dio.patch<Map<String, dynamic>>(
        '${ApiEndpoints.kUsers}/$id/toggle',
      );
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _dio.delete<Map<String, dynamic>>('${ApiEndpoints.kUsers}/$id');
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<AdminNotificationsResult> getNotifications({
    String? search,
    String? type,
    String? status,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kNotifications,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (type != null && type.isNotEmpty) 'type': type,
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );
      final data = _asMap(response.data?['data']);
      final notifications = _readPaginatorList(
        data['notifications'],
      ).map(AdminNotification.fromJson).toList();

      return AdminNotificationsResult(
        notifications: notifications,
        stats: _asMap(data['stats']),
      );
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<AdminNotification> createNotification(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.kNotifications,
        data: data,
      );

      return AdminNotification.fromJson(_asMap(response.data?['data']));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<void> toggleNotification(int id) async {
    try {
      await _dio.patch<Map<String, dynamic>>(
        '${ApiEndpoints.kNotifications}/$id/toggle',
      );
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<void> deleteNotification(int id) async {
    try {
      await _dio.delete<Map<String, dynamic>>(
        '${ApiEndpoints.kNotifications}/$id',
      );
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<bool> getDeliveryEnabled() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kDeliverySettings,
      );
      final data = _asMap(response.data?['data']);

      return data['delivery_enabled'] == true;
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<bool> updateDeliveryEnabled(bool enabled) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.kDeliverySettings,
        data: {'enabled': enabled},
      );
      final data = _asMap(response.data?['data']);

      return data['delivery_enabled'] == true;
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<ReportSummary> getReportSummary({
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kReportsSummary,
        queryParameters: {
          if (startDate != null) 'start_date': startDate,
          if (endDate != null) 'end_date': endDate,
        },
      );

      return ReportSummary.fromJson(_asMap(response.data?['data']));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  List<Map<String, dynamic>> _readPaginatorList(Object? value) {
    final map = _asMap(value);
    final list = map['data'];
    if (list is List) {
      return list.map(_asMap).toList();
    }

    return const [];
  }

  Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }

    return <String, dynamic>{};
  }

  AppException _toAppException(DioException error) {
    final appException = error.error;
    if (appException is AppException) {
      return appException;
    }

    return UnknownException(error.message ?? 'Terjadi kesalahan admin');
  }
}

class AdminUsersResult {
  const AdminUsersResult({required this.users, required this.stats});

  final List<AdminUser> users;
  final Map<String, dynamic> stats;
}

class AdminUser {
  const AdminUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
  });

  final int id;
  final String name;
  final String email;
  final String role;
  final bool isActive;

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '-',
      email: json['email']?.toString() ?? '-',
      role: json['role']?.toString() ?? '-',
      isActive: json['is_active'] == true,
    );
  }
}

class AdminNotificationsResult {
  const AdminNotificationsResult({
    required this.notifications,
    required this.stats,
  });

  final List<AdminNotification> notifications;
  final Map<String, dynamic> stats;
}

class AdminNotification {
  const AdminNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isActive,
  });

  final int id;
  final String title;
  final String message;
  final String type;
  final bool isActive;

  factory AdminNotification.fromJson(Map<String, dynamic> json) {
    return AdminNotification(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '-',
      message: json['message']?.toString() ?? '-',
      type: json['type']?.toString() ?? 'info',
      isActive: json['is_active'] == true,
    );
  }
}

class ReportSummary {
  const ReportSummary({
    required this.totalTransactions,
    required this.totalRevenue,
    required this.totalItems,
  });

  final int totalTransactions;
  final double totalRevenue;
  final int totalItems;

  factory ReportSummary.fromJson(Map<String, dynamic> json) {
    return ReportSummary(
      totalTransactions: (json['total_transactions'] as num?)?.toInt() ?? 0,
      totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0,
      totalItems: (json['total_items'] as num?)?.toInt() ?? 0,
    );
  }
}
