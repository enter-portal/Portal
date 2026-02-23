import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/ui/chats/view_models/chat_list_viewmodel.dart';

final chatListViewModelProvider =
    AsyncNotifierProvider<ChatListViewModel, List<User>>(ChatListViewModel.new);
