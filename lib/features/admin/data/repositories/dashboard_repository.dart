import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/dashboard_stats_model.dart';

class DashboardRepository {
  DashboardRepository({DioClient? dioClient})
    : _dio = (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<DashboardStatsModel> getStats() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kDashboard,
      );

      return DashboardStatsModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Map<String, dynamic> _readMap(Map<String, dynamic>? responseData) {
    final data = responseData?['data'] ?? responseData;
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }

    return <String, dynamic>{};
  }

  AppException _toAppException(DioException error) {
    final appException = error.error;
    if (appException is AppException) {
      return appException;
    }

    return UnknownException(error.message ?? 'Terjadi kesalahan dashboard');
  }
}
