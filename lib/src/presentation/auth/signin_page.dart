import 'package:flutter/material.dart';
import 'package:portal/src/presentation/auth/forget_password_page.dart';
import 'package:portal/src/presentation/navigation/navigation_page.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_page_layout.dart';
import 'package:portal/src/presentation/widgets/password_input.dart';
import 'package:portal/src/presentation/widgets/responsive_spacer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: 'Sign In',
      formKey: formKey,
      children: [
        ShadInputFormField(
          id: 'email',
          label: const Text('Email'),
          leading: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(LucideIcons.mail),
          ),
          placeholder: const Text('Enter your email'),
          validator: (v) {
            return null;
          },
        ),
        const SizedBox(height: 15),
        PasswordInput(
          id: 'password',
          label: const Text('Password'),
          placeholder: const Text('Enter your password'),
        ),
        const SizedBox(height: 15),
        ShadButton.link(
          child: const Text('Forget Password?'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgetPasswordPage(),
              ),
            );
          },
        ),
        ResponsiveSpacer(),
        ShadButton(
          width: double.infinity,
          child: const Text('Sign In'),
          onPressed: () {
            if (formKey.currentState!.saveAndValidate()) {
              print('validation succeeded with ${formKey.currentState!.value}');
            } else {
              print('validation failed');
            }

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const NavigationPage()),
              (Route<dynamic> route) =>
                  false, // This predicate always returns false, removing all routes
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
