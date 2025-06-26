import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatInputBox extends HookConsumerWidget {
  const ChatInputBox({super.key});

  // TODO: Make Container transparent so during scroll you can see the bubbles behind input box
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInputTextEmpty = useState(true);
    final emojiShowing = useState(false);
    final scrollController = useScrollController();
    final textEditingController = useTextEditingController();
    final focusNode = useFocusNode(); // Use useFocusNode for consistency

    // Define _printLatestValue as a local function or directly in the listener
    // so it can access the state variables.
    void printLatestValue() {
      final text = textEditingController.value.text;
      isInputTextEmpty.value = text.isEmpty;
    }

    // Add the listener to the textEditingController
    useEffect(
      () {
        textEditingController.addListener(printLatestValue);
        return () => textEditingController.removeListener(printLatestValue);
      },
      [textEditingController],
    ); // Re-run effect if textEditingController changes

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 25),
          color: Theme.of(context).colorScheme.surface.withAlpha(8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon:
                            (emojiShowing.value)
                                ? const Icon(Icons.keyboard, size: 22.0)
                                : const Icon(Icons.emoji_emotions, size: 22.0),
                        onPressed: () {
                          emojiShowing.value = !emojiShowing.value;
                          if (!emojiShowing.value) {
                            focusNode.requestFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                      Expanded(
                        child: TextField(
                          onTap: () {
                            emojiShowing.value = false;
                          },
                          onChanged: (value) {
                            // The listener already handles isInputTextEmpty,
                            // so direct update here might be redundant but harmless.
                            // isInputTextEmpty.value = value.isEmpty;
                          },
                          minLines: 1,
                          maxLines: 3,
                          focusNode: focusNode,
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            hintText: "Message",
                            border: InputBorder.none,
                          ),
                          scrollController: scrollController,
                        ),
                      ),
                      // Correctly access the value of isInputTextEmpty
                      (isInputTextEmpty.value)
                          ? IconButton(
                            icon: const Icon(Icons.photo_camera, size: 22.0),
                            onPressed: () {},
                          )
                          : Container(),
                      IconButton(
                        icon: const Icon(Icons.attach_file, size: 22.0),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child:
                    (isInputTextEmpty.value)
                        ? InkWell(
                          child: const Icon(Icons.keyboard_voice, size: 25.0),
                          onLongPress: () {},
                        )
                        : InkWell(
                          child: const Icon(Icons.send, size: 25.0),
                          onTap: () {},
                        ),
              ),
            ],
          ),
        ),

        Offstage(
          offstage: !emojiShowing.value,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: SizedBox(
              height: 300,
              child: EmojiPicker(
                textEditingController: textEditingController,
                scrollController: scrollController,
                onEmojiSelected: (category, emoji) {
                  // You might want to handle emoji selection here, e.g., append to text.
                },
                onBackspacePressed: () {
                  textEditingController.text =
                      textEditingController.text.characters
                          .skipLast(1)
                          .toString();
                },
                config: Config(
                  height: 256,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax:
                        28 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.20
                            : 1.0),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  viewOrderConfig: const ViewOrderConfig(
                    top: EmojiPickerItem.categoryBar,
                    middle: EmojiPickerItem.emojiView,
                  ),
                  categoryViewConfig: CategoryViewConfig(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    iconColorSelected: Theme.of(context).colorScheme.primary,
                  ),
                  bottomActionBarConfig: const BottomActionBarConfig(
                    enabled: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
