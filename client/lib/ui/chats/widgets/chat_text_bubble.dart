import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatTextBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String? time;

  const ChatTextBubble({
    super.key,
    required this.isMe,
    required this.text,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 20 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 20),
              ),
              boxShadow: [
                if (isMe)
                  BoxShadow(
                    color: theme.colorScheme.primary.withAlpha(50),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Text(
              text,
              style: theme.textTheme.p.copyWith(
                color: isMe
                    ? theme.colorScheme.primaryForeground
                    : theme.colorScheme.foreground,
                fontSize: 14,
              ),
            ),
          ),
          if (time != null)
            Padding(
              padding: EdgeInsets.only(
                left: isMe ? 0 : 20,
                right: isMe ? 20 : 0,
                bottom: 4,
              ),
              child: Text(
                time!,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontSize: 9,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
