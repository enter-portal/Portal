import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/data/user_model.dart';

class SelectedUserNotifier extends StateNotifier<UserModel?> {
  SelectedUserNotifier() : super(null); // Initial index is 0

  void setUser(UserModel? user) {
    state = user;
  }
}

final selectedUserProvider =
    StateNotifierProvider<SelectedUserNotifier, UserModel?>(
      (ref) => SelectedUserNotifier(),
    );
