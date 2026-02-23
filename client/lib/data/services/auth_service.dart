import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/session.dart';
import 'package:portal/data/model/api_result.dart';
import 'package:portal/data/repositories/auth_repository.dart';
import 'package:portal/data/repositories/fake_auth_repository.dart';

/// Consolidated business logic for Authentication.
/// Acts as a "Service" layer similar to Spring Boot.
class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  Future<ApiResult<Session>> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return ApiResult.failure('Email and password must not be empty');
    }
    return _repository.signIn(email, password);
  }

  Future<ApiResult<Session>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      return ApiResult.failure('All fields must not be empty');
    }
    return _repository.signUp(
      username: username,
      email: email,
      password: password,
    );
  }

  Future<ApiResult<void>> signOut() async {
    return _repository.signOut();
  }

  Future<Session?> restoreSession() async {
    return _repository.getStoredSession();
  }

  Future<ApiResult<void>> forgotPassword(String email) async {
    if (email.isEmpty) return ApiResult.failure('Email is required');
    return _repository.forgotPassword(email);
  }

  Future<ApiResult<void>> verifyOtp(String email, String otp) async {
    if (email.isEmpty || otp.isEmpty) {
      return ApiResult.failure('Email and OTP are required');
    }
    return _repository.verifyOtp(email, otp);
  }

  Future<ApiResult<void>> resetPassword(
    String email,
    String newPassword,
  ) async {
    if (email.isEmpty || newPassword.isEmpty) {
      return ApiResult.failure('Email and new password are required');
    }
    return _repository.resetPassword(email, newPassword);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(authRepositoryProvider));
});
