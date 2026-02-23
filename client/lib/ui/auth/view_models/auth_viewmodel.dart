import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/session.dart';
import 'package:portal/data/services/auth_service.dart';
import 'package:portal/data/services/logger_service.dart';

/// Represents the auth state exposed to the UI.
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  final Session session;
  const AuthAuthenticated(this.session);
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

// ---------------------------------------------------------------------------
// ViewModel
// ---------------------------------------------------------------------------

/// MVVM ViewModel for authentication flows.
///
/// Screens observe [authViewModelProvider] for loading / result states and
/// call methods on the notifier to trigger actions.
class AuthViewModel extends Notifier<AuthState> {
  late final AuthService _authService;

  @override
  AuthState build() {
    _authService = ref.watch(authServiceProvider);

    _checkStoredSession();
    return const AuthInitial();
  }

  // --------------------------------------------------------------------------
  // Internal

  Future<void> _checkStoredSession() async {
    final session = await _authService.restoreSession();
    if (session != null) {
      state = AuthAuthenticated(session);
      appLogger.i('AuthViewModel: restored session for ${session.userId}');
    } else {
      state = const AuthUnauthenticated();
    }
  }

  // --------------------------------------------------------------------------
  // Public actions

  Future<void> signIn(String email, String password) async {
    state = const AuthLoading();
    final result = await _authService.signIn(email, password);
    result.when(
      success: (session) {
        state = AuthAuthenticated(session);
        appLogger.i('AuthViewModel: signed in → ${session.userId}');
      },
      failure: (message) {
        state = AuthError(message);
        appLogger.e('AuthViewModel: signIn failed → $message');
      },
    );
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();
    final result = await _authService.signUp(
      username: username,
      email: email,
      password: password,
    );
    result.when(
      success: (session) {
        state = AuthAuthenticated(session);
        appLogger.i('AuthViewModel: signed up → ${session.userId}');
      },
      failure: (message) {
        state = AuthError(message);
      },
    );
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    await _authService.signOut();
    state = const AuthUnauthenticated();
    appLogger.i('AuthViewModel: signed out');
  }

  Future<void> forgotPassword(String email) async {
    state = const AuthLoading();
    final result = await _authService.forgotPassword(email);
    result.when(
      success: (_) => state = const AuthInitial(),
      failure: (message) => state = AuthError(message),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const AuthLoading();
    final result = await _authService.verifyOtp(email, otp);
    result.when(
      success: (_) => state = const AuthInitial(),
      failure: (message) => state = AuthError(message),
    );
  }

  Future<void> resetPassword(String email, String newPassword) async {
    state = const AuthLoading();
    final result = await _authService.resetPassword(email, newPassword);
    result.when(
      success: (_) => state = const AuthUnauthenticated(),
      failure: (message) => state = AuthError(message),
    );
  }

  void clearError() {
    if (state is AuthError) {
      state = const AuthUnauthenticated();
    }
  }
}
