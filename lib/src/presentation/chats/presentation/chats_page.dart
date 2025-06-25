import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/presentation/chat_list_page.dart';
import 'package:portal/src/presentation/chats/presentation/individual_chat_page.dart';
import 'package:portal/src/presentation/chats/providers/selected_user_provider.dart';
import 'package:portal/src/presentation/widgets/layouts/responsive_layout.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayout(
      mobileLayout: mobileChatPage(context, ref),
      desktopLayout: desktopChatPage(context, ref),
    );
  }

  Widget mobileChatPage(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    return ClipRRect(borderRadius: theme.radius, child: ChatListPage());
  }

  Widget desktopChatPage(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final selectedUser = ref.watch(selectedUserProvider);

    return ClipRRect(
      borderRadius: theme.radius,
      child: ShadResizablePanelGroup(
        children: [
          ShadResizablePanel(
            id: 1,
            defaultSize: .30,
            minSize: .30,
            maxSize: .30,
            child: ChatListPage(),
          ),
          ShadResizablePanel(
            id: 2,
            defaultSize: .70,
            minSize: .70,
            maxSize: .70,
            child: IndividualChatPage(user: selectedUser),
          ),
        ],
      ),
    );
  }
}
