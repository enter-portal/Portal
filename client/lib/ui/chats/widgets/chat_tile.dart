import 'package:flutter/material.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/ui/chats/providers/selected_user_provider.dart';
import 'package:portal/ui/chats/screens/individual_chat_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatTile extends ConsumerWidget {
  final User user;

  const ChatTile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final selectedUser = ref.watch(selectedUserProvider);
    final isSelected = selectedUser?.name == user.name;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: Material(
        color: isSelected
            ? theme.colorScheme.accent.withAlpha(50)
            : Colors.transparent,
        borderRadius: theme.radius,
        child: InkWell(
          borderRadius: theme.radius,
          onTap: () {
            ref.read(selectedUserProvider.notifier).setUser(user);
            final currentScreenWidth = MediaQuery.of(context).size.width;
            if (currentScreenWidth < 1024) {
              // Typical desktop break
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualChatScreen(user: user),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Stack(
                  children: [
                    ShadAvatar(
                      user.avatarUrl,
                      size: const Size(40, 40),
                      placeholder: const Icon(
                        LucideIcons.circleUserRound,
                        size: 28,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.card,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.name,
                              style: theme.textTheme.list.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            user.time,
                            style: theme.textTheme.muted.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.muted.copyWith(
                                color: user.unreadCount > 0
                                    ? theme.colorScheme.foreground
                                    : null,
                                fontWeight: user.unreadCount > 0
                                    ? FontWeight.w500
                                    : null,
                              ),
                            ),
                          ),
                          if (user.unreadCount > 0)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                user.unreadCount.toString(),
                                style: theme.textTheme.small.copyWith(
                                  color: theme.colorScheme.primaryForeground,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
