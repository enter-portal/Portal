import 'package:flutter/material.dart';
import 'package:portal/src/app/config/routes.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_layout.dart';
import 'package:portal/src/presentation/auth/presentation/widgets/password_input.dart';
import 'package:portal/src/presentation/auth/presentation/widgets/responsive_spacer.dart';
import 'package:portal/src/presentation/widgets/portal_icon_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:io';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Reset Password',
      leading: IconButton(
        icon: Icon(
          Platform.isIOS || Platform.isMacOS
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed:
            () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      formKey: formKey,
      children: [
        ShadInputFormField(
          id: 're-enter-email',
          label: const Text('Email'),
          leading: const PortalIconButton(
            icon: Icon(LucideIcons.mail, size: 25),
          ),
          placeholder: const Text('Re-enter your email'),
          validator: (v) {
            return null;
          },
        ),
        const SizedBox(height: 15),
        PasswordInput(
          id: 'new-password',
          label: const Text('New Password'),
          placeholder: const Text('Enter your new password'),
        ),
        const SizedBox(height: 15),
        PasswordInput(
          id: 'new-confirm-password',
          label: const Text('Confirm New Password'),
          placeholder: const Text('Re-enter your new password'),
        ),
        ResponsiveSpacer(),
        ShadButton(
          width: double.infinity,
          child: const Text('Reset Password'),
          onPressed: () {
            if (formKey.currentState!.saveAndValidate()) {
              print('validation succeeded with ${formKey.currentState!.value}');
            } else {
              print('validation failed');
            }

            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home.name,
              (route) => false,
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
