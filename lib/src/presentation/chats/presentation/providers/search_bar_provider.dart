import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarVisibilityNotifier extends StateNotifier<bool> {
  SearchBarVisibilityNotifier() : super(false);
  void hide() {
    state = false;
  }

  void show() {
    state = true;
  }
}

final searchBarVisibilityProvider =
    StateNotifierProvider<SearchBarVisibilityNotifier, bool>(
      (ref) => SearchBarVisibilityNotifier(),
    );
