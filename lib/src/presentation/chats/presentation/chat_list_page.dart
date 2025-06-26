import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/app/config/constants.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_tile.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_popup_menu.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/search_bar.dart';
import 'package:portal/src/presentation/chats/presentation/providers/filtred_user_list_provider.dart';
import 'package:portal/src/presentation/chats/presentation/providers/search_bar_provider.dart';
import 'package:portal/src/presentation/widgets/portal_icon_button.dart';
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
        title: Row(
          children: [
            ShadAvatar(
              AppConstants.appLogo,
              placeholder: Icon(LucideIcons.circleUserRound, size: 50),
            ),
            SizedBox(width: 10),
            Text(AppConstants.appName, style: theme.textTheme.large),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [
          !searchBarVisibility
              ? PortalIconButton(
                icon: Icon(LucideIcons.search, size: 22),
                onTap: () {
                  ref.read(searchBarVisibilityProvider.notifier).show();
                },
              )
              : SizedBox.shrink(),
          const ChatPopupMenu(),
        ],
        bottom:
            searchBarVisibility
                ? PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: PortalSearchBar(),
                )
                : null,
      ),
      body: ListView.separated(
        itemCount: filteredUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatTile(user: filteredUsers[index]);
        },
        separatorBuilder:
            (BuildContext context, int index) => const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(LucideIcons.messageCirclePlus, size: 25),
      ),
    );
  }
}
