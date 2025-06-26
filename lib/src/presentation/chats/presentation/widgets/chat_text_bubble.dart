import 'package:flutter/material.dart';

class ChatTextBubble extends StatelessWidget {
  final String text;
  final Alignment alignment;

  const ChatTextBubble({
    super.key,
    required this.alignment,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
          ),
        ),
      ),
    );
  }
}
