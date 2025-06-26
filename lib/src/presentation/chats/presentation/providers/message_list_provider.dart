import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/data/message_model.dart';

final List<MessageModel> sampleMessages = [
  MessageModel(
    sender: "Alice",
    receiver: "Bob",
    message: "Hey Bob, how are you?",
    messageDigest: "Hey Bob, how are you?",
    type: "text",
    isSent: true,
  ),
  MessageModel(
    sender: "Bob",
    receiver: "Alice",
    message: "Hi Alice! I'm good, thanks. You?",
    messageDigest: "Hi Alice! I'm good...",
    type: "text",
    isSent: false,
  ),
  MessageModel(
    sender: "Alice",
    receiver: "Bob",
    message: "Wanna catch up over the weekend?",
    messageDigest: "Wanna catch up...",
    type: "text",
    isSent: true,
  ),
  MessageModel(
    sender: "Bob",
    receiver: "Alice",
    message: "Sure, let's do that!",
    messageDigest: "Sure, let's do that!",
    type: "text",
    isSent: false,
  ),
  MessageModel(
    sender: "Alice",
    receiver: "Bob",
    message: "Check out this photo 📸",
    messageDigest: "Check out this photo 📸",
    type: "image",
    isSent: true,
  ),
  MessageModel(
    sender: "Bob",
    receiver: "Alice",
    message: "Looks awesome!",
    messageDigest: "Looks awesome!",
    type: "text",
    isSent: false,
  ),
];

final messageListProvider = Provider<List<MessageModel>>((ref) {
  final List<MessageModel> messages = sampleMessages;
  return messages;
});
