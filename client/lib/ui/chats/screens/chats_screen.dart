import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/chats/screens/chat_list_screen.dart';
import 'package:portal/ui/chats/screens/individual_chat_screen.dart';
import 'package:portal/ui/chats/providers/selected_user_provider.dart';
import 'package:portal/ui/core/ui/layouts/responsive_layout.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayout(
      mobileLayout: mobileChatPage(context, ref),
      desktopLayout: desktopChatPage(context, ref),
    );
  }

  Widget mobileChatPage(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    return ClipRRect(borderRadius: theme.radius, child: ChatListScreen());
  }

  Widget desktopChatPage(BuildContext context, WidgetRef ref) {
    final selectedUser = ref.watch(selectedUserProvider);
    return ClipRRect(
      child: ShadResizablePanelGroup(
        dividerSize: 0,
        dividerColor: Colors.transparent,
        children: [
          ShadResizablePanel(
            id: 1,
            defaultSize: .30,
            minSize: .30,
            maxSize: .30,
            child: ChatListScreen(),
          ),
          ShadResizablePanel(
            id: 2,
            defaultSize: .70,
            minSize: .70,
            maxSize: .70,
            child: IndividualChatScreen(user: selectedUser),
          ),
        ],
      ),
    );
  }
}
