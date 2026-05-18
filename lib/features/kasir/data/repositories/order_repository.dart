import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/order_model.dart';

class OrderRepository {
  OrderRepository({Dio? dio, DioClient? dioClient})
    : _dio = dio ?? (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<List<OrderModel>> getPendingOrders() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kOrdersPending,
      );
      final data = _readList(response.data);

      return data.map(OrderModel.fromJson).toList();
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> confirmOrder(int id) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderConfirm, id),
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> cancelOrder(int id, String reason) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderCancel, id),
        data: {'reason': reason},
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> updateOrderStatus(int id, String status) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderUpdateStatus, id),
        data: {'status': status},
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  String _withId(String endpoint, int id) {
    return endpoint.replaceFirst('{id}', id.toString());
  }

  List<Map<String, dynamic>> _readList(Map<String, dynamic>? responseData) {
    final data = responseData?['data'];
    final list = data is Map ? data['data'] : data;

    if (list is! List) {
      return const [];
    }

    return list.map(_asMap).toList();
  }

  Map<String, dynamic> _readMap(Map<String, dynamic>? responseData) {
    return _asMap(responseData?['data'] ?? responseData);
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

    return UnknownException(error.message ?? 'Terjadi kesalahan order');
  }
}
