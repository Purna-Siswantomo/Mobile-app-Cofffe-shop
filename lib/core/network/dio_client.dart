import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage.dart';
import 'app_exception.dart';

class DioClient {
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.kBaseUrl,
        connectTimeout: AppConstants.kConnectTimeout,
        receiveTimeout: AppConstants.kReceiveTimeout,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ErrorInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
  }

  static final DioClient _instance = DioClient._internal();

  late final Dio _dio;

  static DioClient get instance => _instance;

  Dio get dio => _dio;
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final exception = await _mapDioException(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
        message: exception.message,
        stackTrace: err.stackTrace,
      ),
    );
  }

  Future<AppException> _mapDioException(DioException err) async {
    if (_isNetworkError(err)) {
      return const NetworkException();
    }

    switch (err.response?.statusCode) {
      case 401:
        await SecureStorage.deleteToken();
        return const UnauthorizedException();
      case 403:
        return const ForbiddenException();
      case 404:
        return const NotFoundException();
      case 422:
        return ValidationException(_parseValidationErrors(err.response?.data));
      case 500:
        return const ServerException();
      default:
        return UnknownException(
          err.message ?? 'Terjadi kesalahan yang tidak diketahui',
        );
    }
  }

  bool _isNetworkError(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.response == null;
  }

  Map<String, List<String>> _parseValidationErrors(dynamic data) {
    if (data is! Map) {
      return const {};
    }

    final rawErrors = data['errors'];
    if (rawErrors is! Map) {
      return const {};
    }

    return rawErrors.map((key, value) {
      final messages = value is List
          ? value.map((item) => item.toString()).toList()
          : <String>[value.toString()];

      return MapEntry(key.toString(), messages);
    });
  }
}
