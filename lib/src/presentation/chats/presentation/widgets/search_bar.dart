import 'package:flutter/material.dart';
import 'package:portal/src/presentation/chats/providers/filtred_user_list_provider.dart';
import 'package:portal/src/presentation/chats/providers/search_bar_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // Required for useState and useTextEditingController
import 'package:hooks_riverpod/hooks_riverpod.dart'; // Required for HookConsumerWidget

class SearchBar extends HookConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    // Watch the searchQueryProvider to get the current search text
    final currentSearchQuery = ref.watch(searchQueryProvider);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ShadInput(
        placeholder: const Text('Search'),
        leading: ShadButton.ghost(
          width: 25,
          height: 25,
          padding: EdgeInsets.zero,
          onPressed: () {
            // Clear the text controller.
            controller.clear();
            // Clear the search query.
            ref.read(searchQueryProvider.notifier).state = '';
            // Hide Search Bar
            ref.read(searchBarVisibilityProvider.notifier).hide();
          },
          child: Icon(LucideIcons.arrowLeft, size: 25),
        ),
        controller: controller,
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        trailing:
            currentSearchQuery.isNotEmpty
                ? ShadButton.ghost(
                  width: 25,
                  height: 25,
                  padding: EdgeInsets.zero,
                  child: const Icon(LucideIcons.circleX, size: 25),
                  onPressed: () {
                    // Clear search bar and end search.
                    controller.clear();
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                )
                : null, // If not in search progress, no trailing button.
      ),
    );
  }
}
