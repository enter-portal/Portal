import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/calls/presentation/calls_page.dart';
import 'package:portal/src/presentation/chats/presentation/chats_page.dart';
import 'package:portal/src/presentation/navigation/providers/selected_navigation_index_provider.dart';
import 'package:portal/src/presentation/stories/presentation/stories_page.dart';
import 'package:portal/src/presentation/navigation/presentation/widgets/nav_bar.dart';
import 'package:portal/src/presentation/navigation/presentation/widgets/nav_rail.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({super.key});

  // List of pages to display
  static const List<Widget> pages = [ChatsPage(), StoriesPage(), CallsPage()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current selected index from the provider
    final selectedIndex = ref.watch(selectedNavigationIndexProvider);
    // Get the notifier to update the index
    final selectedIndexNotifier = ref.read(
      selectedNavigationIndexProvider.notifier,
    );

    // Determine if we should show NavigationRail or NavigationBar based on screen width
    // A common breakpoint for navigation rail is around 600px, but you can adjust this.
    final bool isLargeScreen =
        MediaQuery.of(context).size.width >=
        ShadTheme.of(context).breakpoints.lg.value;

    var navigationRail = NavRail(
      selectedPageIndex: selectedIndex,
      onDestinationSelected: (int index) {
        selectedIndexNotifier.setIndex(index);
      },
    );

    var navigationBar = NavBar(
      selectedPageIndex: selectedIndex,
      onDestinationSelected: (int index) {
        selectedIndexNotifier.setIndex(index);
      },
    );

    return Scaffold(
      // The body displays the currently selected page
      body: Row(
        children: [
          if (isLargeScreen) // Show NavigationRail for larger screens
            navigationRail,
          // Expanded widget ensures the page content takes the remaining space
          Expanded(child: pages[selectedIndex]),
        ],
      ),
      // Show NavigationBar for smaller screens (typically mobile)
      bottomNavigationBar:
          !isLargeScreen
              ? navigationBar
              : null, // Don't show bottom navigation bar on large screens
    );
  }
}
