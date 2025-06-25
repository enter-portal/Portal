import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/data/user_model.dart';
import 'package:portal/src/presentation/chats/providers/user_list_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredUserProvider = Provider<List<UserModel>>((ref) {
  final allUsers = ref.watch(userListProvider);
  final searchQuery =
      ref
          .watch(searchQueryProvider)
          .toLowerCase(); // Get the search query and make it lowercase for case-insensitive search

  if (searchQuery.isEmpty) {
    return allUsers; // If no search query, return all users
  } else {
    // Filter users whose name contains the search query
    return allUsers.where((user) {
      return user.name.toLowerCase().contains(searchQuery) ||
          user.lastMessage.toLowerCase().contains(searchQuery);
    }).toList();
  }
});
