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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Stack(
                  children: [
                    ShadAvatar(
                      user.avatarUrl,
                      size: const Size(52, 52),
                      placeholder: const Icon(
                        LucideIcons.circleUserRound,
                        size: 40,
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 14,
                        height: 14,
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
                const SizedBox(width: 16),
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
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user.time,
                            style: theme.textTheme.muted.copyWith(fontSize: 12),
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
