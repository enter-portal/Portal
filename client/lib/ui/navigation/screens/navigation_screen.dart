import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/chats/screens/chats_screen.dart';
// import 'package:portal/ui/stories/screens/stories_screen.dart';
// import 'package:portal/ui/calls/screens/calls_screen.dart';
import 'package:portal/ui/navigation/widgets/nav_bar.dart';
import 'package:portal/ui/navigation/widgets/nav_rail.dart';
import 'package:portal/ui/navigation/providers/navigation_provider.dart';
import 'package:portal/ui/core/ui/layouts/responsive_layout.dart';

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({super.key});

  static const _pages = [
    ChatsScreen(),
    // StoriesScreen(),
    // CallsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavigationIndexProvider);

    return ResponsiveLayout(
      mobileLayout: _buildMobile(ref, selectedIndex),
      desktopLayout: _buildDesktop(ref, selectedIndex),
    );
  }

  Widget _buildMobile(WidgetRef ref, int selectedIndex) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: _pages.length > 1
          ? NavBar(
              selectedPageIndex: selectedIndex,
              onDestinationSelected: (i) => ref
                  .read(selectedNavigationIndexProvider.notifier)
                  .setIndex(i),
            )
          : null,
    );
  }

  Widget _buildDesktop(WidgetRef ref, int selectedIndex) {
    return Scaffold(
      body: Row(
        children: [
          if (_pages.length > 1)
            NavRail(
              selectedPageIndex: selectedIndex,
              onDestinationSelected: (i) => ref
                  .read(selectedNavigationIndexProvider.notifier)
                  .setIndex(i),
            ),
          Expanded(child: _pages[selectedIndex]),
        ],
      ),
    );
  }
}
