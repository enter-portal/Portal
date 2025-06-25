import 'package:flutter/material.dart' hide SearchBar;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_tile.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/menu.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/search_bar.dart';
import 'package:portal/src/presentation/chats/providers/filtred_user_list_provider.dart';
import 'package:portal/src/presentation/chats/providers/search_bar_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    // Watch the filteredUserProvider to rebuild when filters change
    final filteredUsers = ref.watch(filteredUserProvider);
    final searchBarVisibility = ref.watch(searchBarVisibilityProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Portal', style: theme.textTheme.h3),
        centerTitle: false,
        automaticallyImplyLeading: false,
        //surfaceTintColor: Colors.transparent,
        actions: [
          !searchBarVisibility
              ? ShadIconButton.ghost(
                onPressed: () {
                  ref.read(searchBarVisibilityProvider.notifier).show();
                },
                icon: Icon(LucideIcons.search, size: 25),
              )
              : SizedBox.shrink(),
          PopoverMenu(),
        ],
        bottom:
            searchBarVisibility
                ? PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: SearchBar(),
                )
                : null,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: filteredUsers.length,
        itemBuilder: (BuildContext context, int index) {
          // Render our item
          return ChatTile(user: filteredUsers[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox.square(
        dimension: 57,
        child: ShadButton(
          leading: const Icon(LucideIcons.messageCirclePlus, size: 25),
          onPressed: () {},
        ),
      ),
    );
  }
}
