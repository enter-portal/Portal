import 'package:flutter/material.dart';
import 'package:portal/ui/auth/widgets/auth_layout.dart';
import 'package:portal/routing/routes.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AuthLayout(
      title: 'Welcome',
      centerTitle: true,
      children: [
        Text(
          'Your portal to privacy',
          style: theme.textTheme.h4,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Take the leap into a new dimension of privacy',
          style: theme.textTheme.muted,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ShadButton(
            child: const Text('New to Portal'),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.signUp.name);
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ShadButton.secondary(
            child: const Text('Existing User'),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.signIn.name);
            },
          ),
        ),
      ],
    );
  }
}
