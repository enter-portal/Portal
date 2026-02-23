import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/message.dart';
import 'package:portal/data/services/chat_service.dart';
import 'package:portal/data/services/logger_service.dart';

/// MVVM ViewModel for individual chat message list.
/// Loads the initial message batch and then merges real-time socket pushes.
class MessageViewModel extends AsyncNotifier<List<Message>> {
  late final ChatService _chatService;
  StreamSubscription<Message>? _sub;

  @override
  Future<List<Message>> build() async {
    _chatService = ref.watch(chatServiceProvider);

    // Load initial messages for the default chat room
    final messages = await _chatService.getMessages('default');
    appLogger.i('MessageViewModel: loaded ${messages.length} messages');

    // Subscribe to the real-time stream (fake or socket)
    _subscribeToStream('default', messages);

    ref.onDispose(() {
      _sub?.cancel();
      appLogger.d('MessageViewModel: stream cancelled');
    });

    return messages;
  }

  void _subscribeToStream(String chatRoomId, List<Message> initial) {
    _sub?.cancel();
    _sub = _chatService.watchMessages(chatRoomId).listen((newMsg) {
      final current = state.value ?? [];
      state = AsyncData([...current, newMsg]);
      appLogger.d('MessageViewModel: new message from ${newMsg.sender}');
    });
  }

  /// Send a new message (local optimistic update; real send via Dio or socket).
  void sendMessage(String text, String senderId, String receiverId) {
    final msg = Message(
      sender: senderId,
      receiver: receiverId,
      message: text,
      messageDigest: text.length > 40 ? '${text.substring(0, 40)}…' : text,
      type: 'text',
      isSent: true,
    );
    final current = state.value ?? [];
    state = AsyncData([...current, msg]);
    appLogger.d('MessageViewModel: sent "$text"');

    // Call service for the actual side effect
    _chatService.sendMessage(
      text: text,
      senderId: senderId,
      receiverId: receiverId,
    );
  }
}
