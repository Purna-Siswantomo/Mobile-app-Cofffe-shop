import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

abstract class SecureStorageBackend {
  Future<void> write({required String key, required String value});

  Future<String?> read({required String key});

  Future<void> delete({required String key});

  Future<void> deleteAll();
}

class FlutterSecureStorageBackend implements SecureStorageBackend {
  const FlutterSecureStorageBackend();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }
}

class SecureStorage {
  static SecureStorageBackend _storage = const FlutterSecureStorageBackend();

  static void overrideStorageForTesting(SecureStorageBackend storage) {
    _storage = storage;
  }

  static void resetStorageForTesting() {
    _storage = const FlutterSecureStorageBackend();
  }

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: kTokenKey, value: token);
    } catch (_) {
      rethrow;
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: kTokenKey);
    } catch (_) {
      return null;
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: kTokenKey);
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> saveUser(String userJson) async {
    try {
      await _storage.write(key: kUserKey, value: userJson);
    } catch (_) {
      rethrow;
    }
  }

  static Future<String?> getUser() async {
    try {
      return await _storage.read(key: kUserKey);
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (_) {
      rethrow;
    }
  }
}
