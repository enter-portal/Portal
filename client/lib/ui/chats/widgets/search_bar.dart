import 'package:flutter/material.dart';
import 'package:portal/ui/core/ui/portal_icon_button.dart';
import 'package:portal/ui/chats/providers/search_providers.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortalSearchBar extends HookConsumerWidget {
  const PortalSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
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
            controller.clear();
            ref.read(searchQueryProvider.notifier).setQuery('');
            ref.read(searchBarVisibilityProvider.notifier).hide();
          },
        ),
        controller: controller,
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).setQuery(value);
        },
        trailing: currentSearchQuery.isNotEmpty
            ? [
                PortalIconButton(
                  padding: EdgeInsets.all(10),
                  icon: const Icon(LucideIcons.circleX, size: 20),
                  onTap: () {
                    controller.clear();
                    ref.read(searchQueryProvider.notifier).setQuery('');
                  },
                ),
              ]
            : null,
      ),
    );
  }
}
