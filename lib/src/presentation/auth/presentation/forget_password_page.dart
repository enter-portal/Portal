import 'package:flutter/material.dart';
import 'package:portal/src/presentation/auth/presentation/otp_verification_page.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_layout.dart';
import 'package:portal/src/presentation/auth/presentation/widgets/responsive_spacer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Forget Password',
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
        ResponsiveSpacer(),
        ShadButton(
          width: double.infinity,
          child: const Text('Forget Password'),
          onPressed: () {
            if (formKey.currentState!.saveAndValidate()) {
              print('validation succeeded with ${formKey.currentState!.value}');
            } else {
              print('validation failed');
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OTPVerificationPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
