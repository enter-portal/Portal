import 'package:flutter/material.dart';
import 'package:portal/src/presentation/auth/presentation/signin_page.dart';
import 'package:portal/src/presentation/auth/presentation/signup_page.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_layout.dart';
import 'package:portal/src/presentation/auth/presentation/widgets/responsive_spacer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AuthLayout(
        children: [
          ResponsiveSpacer(),
          Text('Welcome', style: ShadTheme.of(context).textTheme.h1Large),
          ResponsiveSpacer(),
          UniversalImage('assets/images/svg/portal_1.svg', height: 400),
          ResponsiveSpacer(),
          Text(
            'Your portal to the privacy',
            style: ShadTheme.of(context).textTheme.h4,
          ),
          Text(
            'Take the leap into a new dimension of privacy',
            style: ShadTheme.of(context).textTheme.muted,
          ),
          const SizedBox(height: 10),
          ResponsiveSpacer(),
          ShadButton(
            width: double.infinity,
            child: const Text('New to Portal'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
          ),
          const SizedBox(height: 10),
          ShadButton.secondary(
            width: double.infinity,
            child: const Text('Existing User'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
