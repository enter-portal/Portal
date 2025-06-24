import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/src/presentation/chats/chats_page.dart';
import 'package:portal/src/presentation/chats/individual_chat_page.dart';
import 'package:portal/src/presentation/chats/widgets/dummy_user_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatTile extends ConsumerWidget {
  final User user;

  const ChatTile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    return ListTile(
      leading: ShadAvatar(
        user.avatarUrl,
        placeholder: Icon(LucideIcons.circleUserRound, size: 40),
      ),
      title: Text(user.name, style: theme.textTheme.list),
      subtitle: Text(
        user.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.muted,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(user.time, style: theme.textTheme.muted),
          if (user.unreadCount > 0)
            ShadBadge(child: Text(user.unreadCount.toString())),
        ],
      ),
      onTap: () {
        // Set selected user in provider
        ref.read(selectedUserProvider.notifier).setUser(user);
        final currentScreenWidth = MediaQuery.of(context).size.width;
        if (currentScreenWidth < theme.breakpoints.lg.value) {
          // If the screen width is small, navigate to the individual chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualChatPage(user: user),
            ),
          );
        }
      },
    );
  }
}
