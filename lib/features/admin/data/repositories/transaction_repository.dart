import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  TransactionRepository({Dio? dio, DioClient? dioClient})
    : _dio = dio ?? (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<List<TransactionModel>> getTransactions({
    String? status,
    String? date,
    String? fromDate,
    String? toDate,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kTransactions,
        queryParameters: {
          'page': page,
          if (status != null && status.isNotEmpty) 'status': status,
          if (date != null && date.isNotEmpty) 'date': date,
          if (fromDate != null && fromDate.isNotEmpty) 'from_date': fromDate,
          if (toDate != null && toDate.isNotEmpty) 'to_date': toDate,
        },
      );
      final data = _readList(response.data);

      return data.map(TransactionModel.fromJson).toList();
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<TransactionModel> getTransaction(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.kTransactions}/$id',
      );

      return TransactionModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
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

    return UnknownException(error.message ?? 'Terjadi kesalahan transaksi');
  }
}
