import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedNavigationIndexNotifier extends StateNotifier<int> {
  SelectedNavigationIndexNotifier() : super(0); // Initial index is 0

  void setIndex(int newIndex) {
    state = newIndex;
  }
}

final selectedNavigationIndexProvider =
    StateNotifierProvider<SelectedNavigationIndexNotifier, int>(
      (ref) => SelectedNavigationIndexNotifier(),
    );
