// Define a simple Message class to structure the data
class MessageModel {
  final String sender;
  final String receiver;
  final String message;
  final String messageDigest;
  final String? type;
  final bool? isSent;

  MessageModel({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.messageDigest,
    this.type,
    this.isSent,
  });

  // Factory constructor to create a MessageModel from a Map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map["sender"] as String,
      receiver: map["receiver"] as String,
      message: map["message"] as String,
      messageDigest: map["messageDigest"] as String,
      type: map["type"] as String?, // Nullable
      isSent: map["isSent"] as bool?, // Nullable
    );
  }

  // Convert MessageModel to a Map
  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "receiver": receiver,
      "message": message,
      "messageDigest": messageDigest,
      "type": type,
      "isSent": isSent,
    };
  }
}
