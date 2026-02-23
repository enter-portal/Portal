import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Wraps [FlutterSecureStorage] with a clean async API.
/// Used for storing session tokens, refresh tokens, etc.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<void> clear() => _storage.deleteAll();

  Future<bool> containsKey(String key) => _storage.containsKey(key: key);
}

/// Secure storage keys — define them here to avoid magic strings.
abstract class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String expiresAt = 'expires_at';
}

/// Options best suited for every platform.
const _androidOptions = AndroidOptions();
const _iOSOptions = IOSOptions(
  accessibility: KeychainAccessibility.first_unlock,
);
const _macOSOptions = MacOsOptions(
  accessibility: KeychainAccessibility.first_unlock,
);

final secureStorageProvider = Provider<SecureStorageService>(
  (ref) => SecureStorageService(
    const FlutterSecureStorage(
      aOptions: _androidOptions,
      iOptions: _iOSOptions,
      mOptions: _macOSOptions,
    ),
  ),
);
