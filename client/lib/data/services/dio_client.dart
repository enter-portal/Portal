import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/data/services/logger_service.dart';
import 'package:portal/data/services/secure_storage_service.dart';

/// Pre-configured [Dio] instance.
///
/// When [AppConfigs.useFakeNetwork] is true, the [FakeNetworkInterceptor]
/// short-circuits real HTTP calls and returns fixture data.
/// Flip the flag to false to send real requests.
class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Dio get dio => _dio;
}

// ---------------------------------------------------------------------------
// Interceptors
// ---------------------------------------------------------------------------

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    appLogger.d('→ ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appLogger.i('← ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    appLogger.e('✗ ${err.requestOptions.uri}', error: err);
    super.onError(err, handler);
  }
}

class _AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;

  _AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(StorageKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final dioClientProvider = Provider<DioClient>((ref) {
  final storage = ref.watch(secureStorageProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfigs.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.addAll([_AuthInterceptor(storage), _LoggingInterceptor()]);

  return DioClient(dio);
});
