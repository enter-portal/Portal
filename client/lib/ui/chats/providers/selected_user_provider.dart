import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/user.dart';

class SelectedUserNotifier extends Notifier<User?> {
  @override
  User? build() => null;

  void setUser(User? user) {
    state = user;
  }
}

final selectedUserProvider = NotifierProvider<SelectedUserNotifier, User?>(
  SelectedUserNotifier.new,
);
