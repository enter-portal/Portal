import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/src/presentation/chats/widgets/dummy_user_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class IndividualChatPage extends ConsumerWidget {
  final User? user;
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
              UniversalImage('assets/images/svg/portal_1.svg', height: 400),
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
        title: Text(user!.name, style: theme.textTheme.h4),
        automaticallyImplyLeading: user != null,
      ),
      body: Center(child: Text(user!.lastMessage, style: theme.textTheme.h3)),
    );
  }
}
