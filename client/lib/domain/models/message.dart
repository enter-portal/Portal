/// Domain entity representing a single chat message.
class Message {
  final String sender;
  final String receiver;
  final String message;
  final String messageDigest;
  final String? type;
  final bool? isSent;

  const Message({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.messageDigest,
    this.type,
    this.isSent,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      message: map['message'] as String,
      messageDigest: map['messageDigest'] as String,
      type: map['type'] as String?,
      isSent: map['isSent'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'messageDigest': messageDigest,
      'type': type,
      'isSent': isSent,
    };
  }
}
