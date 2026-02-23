import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/providers/auth_provider.dart';
import 'package:portal/routing/routes.dart';
import 'package:portal/data/services/logger_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Define menu actions
enum ChatMenuAction { newGroup, contacts, logout }

class ChatPopupMenu extends HookConsumerWidget {
  const ChatPopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<ChatMenuAction>(
      onSelected: (ChatMenuAction item) {
        switch (item) {
          case ChatMenuAction.newGroup:
            appLogger.d('ChatMenu: New Group selected');
            break;
          case ChatMenuAction.contacts:
            appLogger.d('ChatMenu: Contacts selected');
            break;
          case ChatMenuAction.logout:
            _showLogoutDialog(context, ref);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ChatMenuAction>>[
        const PopupMenuItem<ChatMenuAction>(
          value: ChatMenuAction.newGroup,
          child: Text('New group'),
        ),
        const PopupMenuItem<ChatMenuAction>(
          value: ChatMenuAction.contacts,
          child: Text('Contacts'),
        ),
        const PopupMenuItem<ChatMenuAction>(
          value: ChatMenuAction.logout,
          child: Text('Logout'),
        ),
      ],
      offset: Offset(0, 40),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Icon(LucideIcons.ellipsisVertical, size: 22),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog.adaptive(
          title: const Text('Are you absolutely sure?'),
          content: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).signOut().then((_) {
                  if (!dialogContext.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    dialogContext,
                    AppRoutes.home.name,
                    (Route<dynamic> route) => false,
                  );
                });
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
