import 'package:flutter/material.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_page_layout.dart';
import 'package:portal/src/presentation/widgets/password_input.dart';
import 'package:portal/src/presentation/widgets/responsive_spacer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: 'Sign Up',
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
        PasswordInput(
          id: 'confirm-password',
          label: const Text('Confirm Password'),
          placeholder: const Text('Enter your password'),
        ),
        ResponsiveSpacer(),
        ShadButton(
          width: double.infinity,
          child: const Text('Sign Up'),
          onPressed: () {
            if (formKey.currentState!.saveAndValidate()) {
              print('validation succeeded with ${formKey.currentState!.value}');
            } else {
              print('validation failed');
            }
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
