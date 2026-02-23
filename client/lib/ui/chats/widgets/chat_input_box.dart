import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatInputBox extends HookConsumerWidget {
  /// Called when the user taps the send button with non-empty text.
  final void Function(String text)? onSend;

  const ChatInputBox({super.key, this.onSend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final isInputTextEmpty = useState(true);
    final emojiShowing = useState(false);
    final textEditingController = useTextEditingController();
    final focusNode = useFocusNode();
    final isMobile = MediaQuery.of(context).size.width < 700;

    useEffect(() {
      void listener() =>
          isInputTextEmpty.value = textEditingController.text.trim().isEmpty;
      textEditingController.addListener(listener);
      return () => textEditingController.removeListener(listener);
    }, [textEditingController]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24,
            top: 8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShadButton.ghost(
                width: 44,
                height: 44,
                padding: EdgeInsets.zero,
                hoverBackgroundColor: Colors.transparent,
                child: Icon(
                  emojiShowing.value ? LucideIcons.keyboard : LucideIcons.smile,
                  size: 22,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  emojiShowing.value = !emojiShowing.value;
                  if (!emojiShowing.value) {
                    focusNode.requestFocus();
                  } else {
                    focusNode.unfocus();
                  }
                },
              ),
              Expanded(
                child: ShadInput(
                  controller: textEditingController,
                  focusNode: focusNode,
                  placeholder: const Text('Type a message...'),
                  minLines: 1,
                  maxLines: 5,
                  decoration: const ShadDecoration(
                    border: ShadBorder.none,
                    focusedBorder: ShadBorder.none,
                    secondaryFocusedBorder: ShadBorder.none,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  onPressed: () => emojiShowing.value = false,
                  onSubmitted: (val) {
                    if (val.trim().isNotEmpty) {
                      onSend?.call(val.trim());
                      textEditingController.clear();
                    }
                  },
                ),
              ),
              ShadButton.ghost(
                width: 44,
                height: 44,
                padding: EdgeInsets.zero,
                hoverBackgroundColor: Colors.transparent,
                child: const Icon(LucideIcons.paperclip, size: 22),
                onPressed: () {},
              ),
              ShadButton(
                width: 44,
                height: 44,
                padding: EdgeInsets.zero,
                decoration: ShadDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isInputTextEmpty.value
                      ? LucideIcons.mic
                      : LucideIcons.sendHorizontal,
                  size: 20,
                  color: theme.colorScheme.primaryForeground,
                ),
                onPressed: () {
                  final text = textEditingController.text.trim();
                  if (text.isNotEmpty) {
                    onSend?.call(text);
                    textEditingController.clear();
                  } else {
                    // Logic for Voice Message
                  }
                },
              ),
            ],
          ),
        ),

        // Emoji Picker
        if (emojiShowing.value)
          SizedBox(
            height: 300,
            child: EmojiPicker(
              textEditingController: textEditingController,
              onEmojiSelected: (category, emoji) {
                isInputTextEmpty.value = false;
              },
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  columns: isMobile ? 10 : 20,
                  emojiSizeMax:
                      28 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.20
                          : 1.0),
                  backgroundColor: theme.colorScheme.background,
                ),
                categoryViewConfig: CategoryViewConfig(
                  backgroundColor: theme.colorScheme.background,
                  indicatorColor: theme.colorScheme.primary,
                  iconColorSelected: theme.colorScheme.primary,
                ),
                bottomActionBarConfig: const BottomActionBarConfig(
                  enabled: false,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
