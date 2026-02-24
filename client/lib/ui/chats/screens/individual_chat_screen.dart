import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/ui/chats/providers/message_provider.dart';
import 'package:portal/ui/chats/widgets/chat_input_box.dart';
import 'package:portal/ui/chats/widgets/chat_popup_menu.dart';
import 'package:portal/ui/chats/widgets/chat_text_bubble.dart';
import 'package:portal/ui/core/ui/portal_animated_logo.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class IndividualChatScreen extends ConsumerWidget {
  final User? user;
  const IndividualChatScreen({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    if (user == null) {
      return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PortalAnimatedLogo(dimension: 300, bounceHeight: 15),
              const SizedBox(height: 24),
              Text(
                'Select a chat to start messaging',
                style: theme.textTheme.h4,
              ),
              const SizedBox(height: 8),
              Text(
                'Explore your portal to privacy and secure communication.',
                style: theme.textTheme.muted,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final asyncMessages = ref.watch(messageViewModelProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: _buildAppBar(context, theme),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: asyncMessages.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => _buildError(theme),
                data: (messages) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: messages.length,
                    itemBuilder: (_, i) {
                      final msg = messages[messages.length - 1 - i];
                      return ChatTextBubble(
                        isMe: msg.sender == 'Bob',
                        text: msg.message,
                        time: '12:00 PM', // Placeholder for now
                      );
                    },
                  );
                },
              ),
            ),
            ChatInputBox(
              onSend: (text) => ref
                  .read(messageViewModelProvider.notifier)
                  .sendMessage(text, 'Bob', user!.name),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ShadThemeData theme) {
    return AppBar(
      titleSpacing: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: Navigator.canPop(context)
          ? ShadButton.ghost(
              width: 44,
              height: 44,
              padding: EdgeInsets.zero,
              hoverBackgroundColor: Colors.transparent,
              child: const Icon(LucideIcons.chevronLeft, size: 24),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ShadAvatar(
              user!.avatarUrl,
              size: const Size(40, 40),
              placeholder: const Icon(LucideIcons.circleUserRound, size: 32),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user!.name,
                  style: theme.textTheme.list.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Online',
                  style: theme.textTheme.small.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ShadButton.ghost(
          width: 44,
          height: 44,
          padding: EdgeInsets.zero,
          hoverBackgroundColor: Colors.transparent,
          child: const Icon(LucideIcons.phone, size: 20),
          onPressed: () {},
        ),
        ShadButton.ghost(
          width: 44,
          height: 44,
          padding: EdgeInsets.zero,
          hoverBackgroundColor: Colors.transparent,
          child: const Icon(LucideIcons.video, size: 20),
          onPressed: () {},
        ),
        const ChatPopupMenu(),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildError(ShadThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.messageCircleX, size: 48),
          const SizedBox(height: 12),
          Text('Failed to load messages', style: theme.textTheme.p),
        ],
      ),
    );
  }
}
