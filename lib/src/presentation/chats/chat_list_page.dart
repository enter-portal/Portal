import 'package:flutter/material.dart';
import 'package:portal/src/presentation/chats/widgets/chat_tile.dart';
import 'package:portal/src/presentation/chats/widgets/dummy_user_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final users = getUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Portal', style: theme.textTheme.h3),
        centerTitle: false,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          // Render our item
          return ChatTile(user: users[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
