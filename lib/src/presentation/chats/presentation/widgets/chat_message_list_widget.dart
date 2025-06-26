import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/data/message_model.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_text_bubble.dart';
import 'package:portal/src/presentation/chats/presentation/providers/message_list_provider.dart';

// 🌎 Project imports:

/// https://akshitmadan.medium.com/flutter-ui-of-send-chat-message-text-field-38aae5c50a0f
class ChatMessageList extends ConsumerWidget {
  const ChatMessageList({super.key});

  List<ChatTextBubble> _createChatTextBubbleList(WidgetRef ref) {
    List<MessageModel> messages = ref.watch(messageListProvider);

    List<ChatTextBubble> newMessages = [];
    for (var message in messages) {
      // TODO: Fix here
      if (message.sender == "Bob") {
        newMessages.add(
          ChatTextBubble(
            alignment: Alignment.centerRight,
            text: message.message,
          ),
        );
      } else {
        newMessages.add(
          ChatTextBubble(
            alignment: Alignment.centerLeft,
            text: message.message,
          ),
        );
      }
    }
    return newMessages.reversed.toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ChatTextBubble> messages = _createChatTextBubbleList(ref);

    /// Messages page
    return ListView.separated(
      shrinkWrap: true,
      reverse: true,
      itemCount: messages.length,
      separatorBuilder:
          (BuildContext context, int index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) => messages[index],
    );
  }
}
