import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/presentation/chats/data/user_model.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_input_box.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_message_list_widget.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/chat_popup_menu.dart';
import 'package:portal/src/presentation/chats/presentation/widgets/search_bar.dart';
import 'package:portal/src/presentation/widgets/portal_icon_button.dart';
import 'package:portal/src/presentation/widgets/portal_animated_logo.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

class IndividualChatPage extends ConsumerWidget {
  final UserModel? user;
  const IndividualChatPage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome to portal', style: theme.textTheme.h2),
              PortalAnimatedLogo(dimension: 400),
              Text(
                'Your portal to the privacy',
                style: ShadTheme.of(context).textTheme.h3,
              ),
              Text(
                'Take the leap into a new dimension of privacy',
                style: ShadTheme.of(context).textTheme.lead,
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ShadAvatar(
              user!.avatarUrl,
              placeholder: Icon(LucideIcons.circleUserRound, size: 50),
            ),
            SizedBox(width: 20),
            Text(user!.name, style: theme.textTheme.large),
          ],
        ),
        automaticallyImplyLeading: user != null,
        centerTitle: false,
        forceMaterialTransparency: true,
        actions: [
          PortalIconButton(
            icon: Icon(LucideIcons.search, size: 22),
            onTap: () {},
          ),
          const ChatPopupMenu(),
        ],
        bottom:
            false
                ? PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: PortalSearchBar(),
                )
                : null,
      ),
      body: const Column(
        children: [Expanded(child: ChatMessageList()), ChatInputBox()],
      ),
    );
  }
}
