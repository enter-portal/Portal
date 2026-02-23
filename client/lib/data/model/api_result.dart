import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A typed result value to avoid raw exceptions propagating into ViewModels.
///
/// Usage:
/// ```dart
/// final result = await repository.signIn(email, password);
/// result.when(
///   success: (session) => ...,
///   failure: (err) => ...,
/// );
/// ```
sealed class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) = ApiSuccess<T>;
  factory ApiResult.failure(String message, {Object? error}) = ApiFailure<T>;

  bool get isSuccess => this is ApiSuccess<T>;
  bool get isFailure => this is ApiFailure<T>;

  T? get dataOrNull => switch (this) {
    ApiSuccess<T>(data: final d) => d,
    ApiFailure<T>() => null,
  };

  String? get errorOrNull => switch (this) {
    ApiSuccess<T>() => null,
    ApiFailure<T>(message: final m) => m,
  };

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  }) => switch (this) {
    ApiSuccess<T>(data: final d) => success(d),
    ApiFailure<T>(message: final m) => failure(m),
  };
}

final class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

final class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final Object? error;
  const ApiFailure(this.message, {this.error});
}

/// Provider placeholder — real Dio client will be shaped around this.
final apiResultProvider = Provider<ApiResult<void>>(
  (ref) => const ApiSuccess(null),
);
