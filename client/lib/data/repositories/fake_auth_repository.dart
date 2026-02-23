import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/domain/models/session.dart';
import 'package:portal/data/model/api_result.dart';
import 'package:portal/data/repositories/auth_repository.dart';
import 'package:portal/data/services/logger_service.dart';
import 'package:portal/data/services/secure_storage_service.dart';

/// Fake [AuthRepository] that simulates network calls with [Future.delayed].
/// All methods write / read from [SecureStorageService].
/// Replace this with a real [DioClient]-backed implementation when the
/// backend is ready: just swap the provider binding in [authRepositoryProvider].
class FakeAuthRepository implements AuthRepository {
  final SecureStorageService _storage;

  FakeAuthRepository(this._storage);

  // ---------------------------------------------------------------------------
  // Helpers

  Session _buildFakeSession(String email) {
    return Session(
      accessToken: 'fake.jwt.access.${email.hashCode}',
      refreshToken: 'fake.jwt.refresh.${email.hashCode}',
      userId: 'user_${email.hashCode.abs()}',
      expiresAt: DateTime.now().toUtc().add(const Duration(hours: 1)),
    );
  }

  Future<void> _persistSession(Session session) async {
    await Future.wait([
      _storage.write(StorageKeys.accessToken, session.accessToken),
      _storage.write(StorageKeys.refreshToken, session.refreshToken),
      _storage.write(StorageKeys.userId, session.userId),
      _storage.write(
        StorageKeys.expiresAt,
        session.expiresAt.toIso8601String(),
      ),
    ]);
  }

  // ---------------------------------------------------------------------------
  // AuthRepository implementation

  @override
  Future<ApiResult<Session>> signIn(String email, String password) async {
    appLogger.i('🔐 [FakeAuth] signIn($email)');
    await Future.delayed(AppConfigs.fakeMediumDelay);
    // Simulate a wrong-password error for the email 'fail@example.com'
    if (email.contains('fail')) {
      return ApiResult.failure('Incorrect email or password.');
    }
    final session = _buildFakeSession(email);
    await _persistSession(session);
    appLogger.i('🔐 [FakeAuth] signed in → ${session.userId}');
    return ApiResult.success(session);
  }

  @override
  @override
  Future<ApiResult<Session>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    appLogger.i('🔐 [FakeAuth] signUp($username, $email)');
    await Future.delayed(AppConfigs.fakeLongDelay);
    final session = _buildFakeSession(email);
    await _persistSession(session);
    appLogger.i('🔐 [FakeAuth] signed up → ${session.userId}');
    return ApiResult.success(session);
  }

  @override
  Future<ApiResult<void>> signOut() async {
    appLogger.i('🔐 [FakeAuth] signOut');
    await Future.delayed(AppConfigs.fakeShortDelay);
    await _storage.clear();
    return ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> forgotPassword(String email) async {
    appLogger.i('🔐 [FakeAuth] forgotPassword($email)');
    await Future.delayed(AppConfigs.fakeMediumDelay);
    return ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> verifyOtp(String email, String otp) async {
    appLogger.i('🔐 [FakeAuth] verifyOtp(otp=$otp)');
    await Future.delayed(AppConfigs.fakeMediumDelay);
    if (otp == '0000') {
      return ApiResult.failure('OTP has expired. Please request a new one.');
    }
    return ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> resetPassword(
    String email,
    String newPassword,
  ) async {
    appLogger.i('🔐 [FakeAuth] resetPassword($email)');
    await Future.delayed(AppConfigs.fakeMediumDelay);
    return ApiResult.success(null);
  }

  @override
  Future<Session?> getStoredSession() async {
    final token = await _storage.read(StorageKeys.accessToken);
    final refreshToken = await _storage.read(StorageKeys.refreshToken);
    final userId = await _storage.read(StorageKeys.userId);
    final expiresAtStr = await _storage.read(StorageKeys.expiresAt);
    if (token == null || userId == null || expiresAtStr == null) return null;
    final session = Session(
      accessToken: token,
      refreshToken: refreshToken ?? '',
      userId: userId,
      expiresAt: DateTime.parse(expiresAtStr),
    );
    if (session.isExpired) {
      appLogger.w('🔐 Stored session expired');
      return null;
    }
    return session;
  }
}

/// Swap [FakeAuthRepository] for a real Dio-backed one by changing this line.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FakeAuthRepository(ref.watch(secureStorageProvider)),
);
