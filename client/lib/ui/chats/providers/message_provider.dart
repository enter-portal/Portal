import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/domain/models/message.dart';
import 'package:portal/ui/chats/view_models/message_viewmodel.dart';

final messageViewModelProvider =
    AsyncNotifierProvider<MessageViewModel, List<Message>>(
      MessageViewModel.new,
    );
