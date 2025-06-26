import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedPageIndex,
    required this.onDestinationSelected,
  });

  final int selectedPageIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(LucideIcons.messageCircleMore),
          label: 'Chats',
        ),
        NavigationDestination(
          icon: Icon(LucideIcons.galleryHorizontalEnd),
          label: 'Stories',
        ),
        NavigationDestination(icon: Icon(LucideIcons.phone), label: 'Calls'),
      ],
      selectedIndex: selectedPageIndex,
      onDestinationSelected: onDestinationSelected,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
