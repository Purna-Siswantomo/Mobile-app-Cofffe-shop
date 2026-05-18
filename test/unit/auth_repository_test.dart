import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:arpul_mobile/core/constants/api_constants.dart';
import 'package:arpul_mobile/core/network/app_exception.dart';
import 'package:arpul_mobile/core/network/dio_client.dart';
import 'package:arpul_mobile/core/storage/secure_storage.dart';
import 'package:arpul_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeSecureStorage storage;

  setUp(() {
    storage = FakeSecureStorage();
    SecureStorage.overrideStorageForTesting(storage);
  });

  tearDown(SecureStorage.resetStorageForTesting);

  test('login berhasil return UserModel dan simpan token', () async {
    final dio = _createDio(
      (options) => _jsonResponse(200, {
        'status': true,
        'message': 'OK',
        'data': {
          'token': 'token-123',
          'user': {
            'id': 1,
            'name': 'Admin',
            'email': 'admin@example.com',
            'role': 'admin',
            'is_active': true,
          },
        },
      }),
    );
    final repository = AuthRepository(dio: dio);

    final user = await repository.login('admin@example.com', 'password');

    expect(user.id, 1);
    expect(user.isAdmin, isTrue);
    expect(await SecureStorage.getToken(), 'token-123');
    expect(
      await SecureStorage.getUser(),
      contains('"email":"admin@example.com"'),
    );
  });

  test('login gagal throw UnauthorizedException', () async {
    final dio = _createDio(
      (options) => _jsonResponse(401, {'message': 'Unauthorized'}),
    );
    final repository = AuthRepository(dio: dio);

    expect(
      () => repository.login('admin@example.com', 'wrong-password'),
      throwsA(isA<UnauthorizedException>()),
    );
  });

  test('logout berhasil clear token dari storage', () async {
    await SecureStorage.saveToken('token-123');
    final dio = _createDio((options) => _jsonResponse(200, {'status': true}));
    final repository = AuthRepository(dio: dio);

    await repository.logout();

    expect(await SecureStorage.getToken(), isNull);
  });
}

Dio _createDio(FutureOr<ResponseBody> Function(RequestOptions) handler) {
  final dio = Dio(BaseOptions(baseUrl: kBaseUrl));
  dio.httpClientAdapter = FakeHttpClientAdapter(handler);
  dio.interceptors.add(ErrorInterceptor());
  return dio;
}

ResponseBody _jsonResponse(int statusCode, Object body) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

class FakeHttpClientAdapter implements HttpClientAdapter {
  FakeHttpClientAdapter(this.handler);

  final FutureOr<ResponseBody> Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

class FakeSecureStorage implements SecureStorageBackend {
  final Map<String, String> _data = {};

  @override
  Future<void> write({required String key, required String value}) async {
    _data[key] = value;
  }

  @override
  Future<String?> read({required String key}) async {
    return _data[key];
  }

  @override
  Future<void> delete({required String key}) async {
    _data.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _data.clear();
  }
}
