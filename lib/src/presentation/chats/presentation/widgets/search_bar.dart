import 'package:flutter/material.dart';
import 'package:portal/src/presentation/chats/presentation/providers/filtred_user_list_provider.dart';
import 'package:portal/src/presentation/chats/presentation/providers/search_bar_provider.dart';
import 'package:portal/src/presentation/widgets/portal_icon_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // Required for useState and useTextEditingController
import 'package:hooks_riverpod/hooks_riverpod.dart'; // Required for HookConsumerWidget

class PortalSearchBar extends HookConsumerWidget {
  const PortalSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    // Watch the searchQueryProvider to get the current search text
    final currentSearchQuery = ref.watch(searchQueryProvider);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SearchBar(
        autoFocus: true,
        hintText: 'Search',
        constraints: BoxConstraints(maxHeight: 70),
        leading: PortalIconButton(
          padding: EdgeInsets.all(10),
          icon: Icon(LucideIcons.arrowLeft, size: 20),
          onTap: () {
            // Clear the text controller.
            controller.clear();
            // Clear the search query.
            ref.read(searchQueryProvider.notifier).state = '';
            // Hide Search Bar
            ref.read(searchBarVisibilityProvider.notifier).hide();
          },
        ),
        controller: controller,
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        trailing:
            currentSearchQuery.isNotEmpty
                ? [
                  PortalIconButton(
                    padding: EdgeInsets.all(10),
                    icon: const Icon(LucideIcons.circleX, size: 20),
                    onTap: () {
                      // Clear search bar and end search.
                      controller.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  ),
                ]
                : null, // If not in search progress, no trailing button.
      ),
    );
  }
}
