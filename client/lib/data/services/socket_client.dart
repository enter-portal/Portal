import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/data/services/logger_service.dart';
import 'package:portal/data/services/secure_storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// Manages the Socket.IO connection lifecycle.
///
/// - Call [connect] once after sign-in.
/// - Call [disconnect] on sign-out.
/// - Use [on]/[off] to subscribe to events.
/// - Use [emit] to send events to the server.
class SocketClient {
  io.Socket? _socket;

  final SecureStorageService _storage;

  SocketClient(this._storage);

  bool get isConnected => _socket?.connected ?? false;

  /// Connects (or reconnects) to the socket server with the current JWT.
  Future<void> connect() async {
    if (_socket?.connected == true) return;

    final token = await _storage.read(StorageKeys.accessToken);

    _socket = io.io(
      AppConfigs.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setExtraHeaders({'Authorization': 'Bearer ${token ?? ''}'})
          .build(),
    );

    _socket!.onConnect((_) => appLogger.i('🔌 Socket connected'));
    _socket!.onDisconnect((_) => appLogger.w('🔌 Socket disconnected'));
    _socket!.onError((e) => appLogger.e('🔌 Socket error', error: e));
    _socket!.onConnectError(
      (e) => appLogger.e('🔌 Socket connect error', error: e),
    );

    _socket!.connect();
  }

  /// Subscribe to a server event.
  void on(String event, Function(dynamic) handler) =>
      _socket?.on(event, handler);

  /// Unsubscribe from a server event.
  void off(String event) => _socket?.off(event);

  /// Emit an event to the server.
  void emit(String event, [dynamic data]) => _socket?.emit(event, data);

  /// Gracefully disconnect and dispose.
  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    appLogger.i('🔌 Socket disposed');
  }
}

final socketClientProvider = Provider<SocketClient>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final client = SocketClient(storage);

  // Cleanup on provider disposal (e.g. sign-out scope reset)
  ref.onDispose(client.disconnect);

  return client;
});
