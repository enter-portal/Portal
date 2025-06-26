import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/app/config/routes.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Define menu actions
enum ChatMenuAction { newGroup, contacts, logout }

class ChatPopupMenu extends HookConsumerWidget {
  const ChatPopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<ChatMenuAction>(
      onSelected: (ChatMenuAction item) {
        // Handle selected menu item
        switch (item) {
          case ChatMenuAction.newGroup:
            print('New Group selected!');
            // Implement navigation or dialog for new group
            break;
          case ChatMenuAction.contacts:
            print('Contacts selected!');
            // Implement navigation to contacts
            break;
          case ChatMenuAction.logout:
            _showLogoutDialog(context);
            break;
        }
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<ChatMenuAction>>[
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
      // The child is the widget that the user taps to open the menu.
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20.0,
        ), // Adjust padding as needed
        child: Icon(
          LucideIcons.ellipsisVertical,
          size: 22,
        ), // Vertical ellipsis icon
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop(false); // Close dialog, return false
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  dialogContext,
                  AppRoutes.home.name,
                  (Route<dynamic> route) => false, // This removes all routes
                );
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
