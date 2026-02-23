import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/data/services/chat_service.dart';
import 'package:portal/data/services/logger_service.dart';

/// MVVM ViewModel for the chat list screen.
/// Exposes `AsyncValue<List<User>>` so the UI automatically handles
/// loading / error / data states.
class ChatListViewModel extends AsyncNotifier<List<User>> {
  late final ChatService _chatService;

  @override
  Future<List<User>> build() async {
    _chatService = ref.watch(chatServiceProvider);
    appLogger.i('ChatListViewModel: loading users');
    return _chatService.getUsers();
  }

  /// Pull-to-refresh.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_chatService.getUsers);
  }
}
