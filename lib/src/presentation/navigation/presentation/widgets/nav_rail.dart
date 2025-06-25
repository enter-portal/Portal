import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
    required this.selectedPageIndex,
    this.onDestinationSelected,
  });

  final int selectedPageIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.inversePrimary.withValues(alpha: 0.5),
      labelType: NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Icon(
          LucideIcons.circleUser,
          size: 38.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(LucideIcons.messageCircleMore),
          label: Text('Chats'),
        ),
        NavigationRailDestination(
          icon: Icon(LucideIcons.galleryHorizontalEnd),
          label: Text('Stories'),
        ),
        NavigationRailDestination(
          icon: Icon(LucideIcons.phone),
          label: Text('Calls'),
        ),
      ],
      selectedIndex: selectedPageIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
