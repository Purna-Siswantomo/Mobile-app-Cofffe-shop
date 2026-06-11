import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/secure_storage.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

@riverpod
class AuthState extends _$AuthState {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  UserModel? get currentUser => state.valueOrNull;

  bool get isLoggedIn => currentUser != null;

  bool get isAdmin => currentUser?.isAdmin ?? false;

  bool get isKasir => currentUser?.isKasir ?? false;

  @override
  Future<UserModel?> build() async {
    final token = await SecureStorage.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      return await _repository.getProfile();
    } catch (_) {
      await SecureStorage.clearAll();
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.login(email, password);
      state = AsyncValue.data(user);
    } catch (error) {
      state = const AsyncValue.data(null);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _repository.logout();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
