import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/message.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/data/repositories/message_repository.dart';
import 'package:portal/data/repositories/user_repository.dart';
import 'package:portal/data/repositories/fake_chat_repository.dart';

/// Consolidated service for all Chat-related business logic.
/// Acts as the single entry point for the UI/ViewModels.
class ChatService {
  final UserRepository _userRepo;
  final MessageRepository _messageRepo;

  ChatService(this._userRepo, this._messageRepo);

  /// Retrieves the list of users/contacts.
  Future<List<User>> getUsers() {
    return _userRepo.getUsers();
  }

  /// Retrieves the initial messages for a chat room.
  Future<List<Message>> getMessages(String chatRoomId) {
    return _messageRepo.getMessages(chatRoomId);
  }

  /// Observes real-time messages for a chat room.
  Stream<Message> watchMessages(String chatRoomId) {
    return _messageRepo.watchMessages(chatRoomId);
  }

  /// Logic for sending a message (includes validation, optimistic updates logic if needed).
  Future<void> sendMessage({
    required String text,
    required String senderId,
    required String receiverId,
  }) async {
    // Basic validation
    if (text.trim().isEmpty) return;

    // TODO: Implement real repository call here when backend is ready
  }
}

final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(
    ref.watch(userRepositoryProvider),
    ref.watch(messageRepositoryProvider),
  );
});
