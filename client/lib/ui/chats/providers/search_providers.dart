import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/ui/chats/providers/chat_list_provider.dart';

/// Search query state.
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

/// Search bar visibility state.
class SearchBarVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void hide() => state = false;
  void show() => state = true;
}

final searchBarVisibilityProvider =
    NotifierProvider<SearchBarVisibilityNotifier, bool>(
      SearchBarVisibilityNotifier.new,
    );

/// Derived provider — filters the async user list by the current search query.
final filteredUserProvider = Provider<List<User>>((ref) {
  final asyncUsers = ref.watch(chatListViewModelProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  final users = asyncUsers.value ?? [];
  if (query.isEmpty) return users;

  return users.where((user) {
    return user.name.toLowerCase().contains(query) ||
        user.lastMessage.toLowerCase().contains(query);
  }).toList();
});
