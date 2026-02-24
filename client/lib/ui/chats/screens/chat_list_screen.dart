import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/ui/chats/providers/search_providers.dart';
import 'package:portal/ui/chats/providers/chat_list_provider.dart';
import 'package:portal/ui/chats/widgets/chat_popup_menu.dart';
import 'package:portal/ui/chats/widgets/chat_tile.dart';
import 'package:portal/ui/chats/widgets/search_bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final searchBarVisibility = ref.watch(searchBarVisibilityProvider);
    final asyncUsers = ref.watch(chatListViewModelProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, ref, theme, searchBarVisibility),
            Expanded(
              child: asyncUsers.when(
                loading: () => ListView.builder(
                  itemCount: 8,
                  padding: const EdgeInsets.only(top: 12),
                  itemBuilder: (_, _) => _UserShimmer(),
                ),
                error: (err, _) => _buildErrorState(theme, ref),
                data: (users) {
                  final query = ref.watch(searchQueryProvider).toLowerCase();
                  final visible = query.isEmpty
                      ? users
                      : users
                            .where(
                              (u) =>
                                  u.name.toLowerCase().contains(query) ||
                                  u.lastMessage.toLowerCase().contains(query),
                            )
                            .toList();

                  if (visible.isEmpty) {
                    return _buildEmptyState(theme);
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        ref.read(chatListViewModelProvider.notifier).refresh(),
                    child: ListView.builder(
                      itemCount: visible.length,
                      padding: const EdgeInsets.only(top: 12),
                      itemBuilder: (_, i) => ChatTile(user: visible[i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 44,
        height: 44,
        child: FloatingActionButton(
          elevation: 4,
          highlightElevation: 8,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.primaryForeground,
          onPressed: () {},
          child: const Icon(LucideIcons.plus, size: 20),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    ShadThemeData theme,
    bool searchBarVisibility,
  ) {
    if (searchBarVisibility) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: PortalSearchBar(),
      );
    }

    return AppBar(
      title: const Text(AppConfigs.appName),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: [
        ShadButton.ghost(
          width: 36,
          height: 36,
          padding: EdgeInsets.zero,
          hoverBackgroundColor: Colors.transparent,
          onPressed: () =>
              ref.read(searchBarVisibilityProvider.notifier).show(),
          child: const Icon(LucideIcons.search, size: 20),
        ),
        const ChatPopupMenu(),
      ],
    );
  }

  Widget _buildErrorState(ShadThemeData theme, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.cloudOff,
            size: 64,
            color: theme.colorScheme.mutedForeground,
          ),
          const SizedBox(height: 24),
          Text('Something went wrong', style: theme.textTheme.h4),
          const SizedBox(height: 8),
          Text('We couldn\'t load your chats.', style: theme.textTheme.muted),
          const SizedBox(height: 32),
          ShadButton.outline(
            child: const Text('Try Again'),
            onPressed: () =>
                ref.read(chatListViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ShadThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.messageSquareDashed,
            size: 64,
            color: theme.colorScheme.mutedForeground,
          ),
          const SizedBox(height: 24),
          Text('No messages yet', style: theme.textTheme.h4),
          const SizedBox(height: 8),
          Text(
            'Start a conversation to see it here.',
            style: theme.textTheme.muted,
          ),
        ],
      ),
    );
  }
}

class _UserShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.muted,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
