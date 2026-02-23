import 'package:portal/domain/models/session.dart';
import 'package:portal/data/model/api_result.dart';

/// Contract for all authentication operations.
/// The data layer provides implementations (fake or real).
abstract interface class AuthRepository {
  /// Sign in with email and password. Returns a [Session] on success.
  Future<ApiResult<Session>> signIn(String email, String password);

  /// Register a new account.
  Future<ApiResult<Session>> signUp({
    required String username,
    required String email,
    required String password,
  });

  /// Destroy the local session and notify the backend.
  Future<ApiResult<void>> signOut();

  /// Send a password-reset OTP to [email].
  Future<ApiResult<void>> forgotPassword(String email);

  /// Verify the OTP code for [email].
  Future<ApiResult<void>> verifyOtp(String email, String otp);

  /// Reset the password once OTP has been verified.
  Future<ApiResult<void>> resetPassword(String email, String newPassword);

  /// Returns the stored session if still valid, null otherwise.
  Future<Session?> getStoredSession();
}
