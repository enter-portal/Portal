import 'package:portal/domain/models/message.dart';

/// Abstract contract for message data access.
abstract interface class MessageRepository {
  /// Returns all messages for [chatRoomId].
  Future<List<Message>> getMessages(String chatRoomId);

  /// Stream of new incoming messages for real-time updates.
  /// In the fake implementation this emits periodic dummy messages.
  /// The socket-backed implementation will listen to socket.io events.
  Stream<Message> watchMessages(String chatRoomId);
}
