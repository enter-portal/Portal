import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedNavigationIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}

final selectedNavigationIndexProvider =
    NotifierProvider<SelectedNavigationIndexNotifier, int>(
      SelectedNavigationIndexNotifier.new,
    );
