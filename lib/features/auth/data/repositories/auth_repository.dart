import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository({Dio? dio, DioClient? dioClient})
    : _dio = dio ?? (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.kLogin,
        data: {'email': email, 'password': password},
      );
      final responseData = response.data ?? <String, dynamic>{};
      final data = _asMap(responseData['data'] ?? responseData);
      final token = _readToken(data, responseData);
      final userJson = _asMap(data['user'] ?? responseData['user'] ?? data);
      final user = UserModel.fromJson(userJson);

      if (token != null && token.isNotEmpty) {
        await SecureStorage.saveToken(token);
      }
      await SecureStorage.saveUser(jsonEncode(user.toJson()));

      return user;
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post<void>(ApiEndpoints.kLogout);
      await SecureStorage.clearAll();
    } on DioException catch (error) {
      await SecureStorage.clearAll();
      throw _toAppException(error);
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.kMe);
      final responseData = response.data ?? <String, dynamic>{};
      final data = _asMap(responseData['data'] ?? responseData);

      return UserModel.fromJson(data);
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  String? _readToken(
    Map<String, dynamic> data,
    Map<String, dynamic> responseData,
  ) {
    final token =
        data['token'] ??
        data['access_token'] ??
        responseData['token'] ??
        responseData['access_token'];

    return token?.toString();
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

    return UnknownException(error.message ?? 'Terjadi kesalahan auth');
  }
}
