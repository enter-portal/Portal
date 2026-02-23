import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/widgets/auth_layout.dart';
import 'package:portal/ui/auth/view_models/auth_viewmodel.dart';
import 'package:portal/ui/auth/providers/auth_provider.dart';
import 'package:portal/routing/routes.dart';
import 'package:portal/ui/core/ui/password_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final formKey = GlobalKey<ShadFormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    ref.listen<AuthState>(authViewModelProvider, (_, next) {
      if (next is AuthUnauthenticated) {
        ShadToaster.of(context).show(
          const ShadToast(
            title: Text('Password Reset Successful'),
            description: Text('You can now sign in with your new password.'),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home.name,
          (_) => false,
        );
      } else if (next is AuthError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Error'),
            description: Text(next.message),
          ),
        );
        ref.read(authViewModelProvider.notifier).clearError();
      }
    });

    final isLoading = ref.watch(authViewModelProvider) is AuthLoading;

    return AuthLayout(
      title: 'Reset Password',
      isLoading: isLoading,
      formKey: formKey,
      showBackButton: true,
      onBack: () => Navigator.of(context).popUntil((route) => route.isFirst),
      children: [
        const SizedBox(height: 8),
        Text(
          'Please enter your email and \n matching new passwords below.',
          style: theme.textTheme.muted,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ShadInputFormField(
          id: 're-enter-email',
          leading: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(LucideIcons.mail, size: 18),
          ),
          placeholder: const Text('Email'),
          keyboardType: TextInputType.emailAddress,
          validator: (v) => v.isEmpty ? 'Email is required' : null,
        ),
        const SizedBox(height: 16),
        PasswordInput(
          id: 'new-password',
          placeholder: const Text('New Password'),
          controller: _passwordController,
        ),
        const SizedBox(height: 16),
        PasswordInput(
          id: 'new-confirm-password',
          placeholder: const Text('Confirm New Password'),
          validator: (v) {
            final pass = _passwordController.text;
            if (v != pass) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 32),
        ShadButton(
          size: ShadButtonSize.lg,
          onPressed: isLoading
              ? null
              : () {
                  if (formKey.currentState!.saveAndValidate()) {
                    final values = formKey.currentState!.value;
                    ref
                        .read(authViewModelProvider.notifier)
                        .resetPassword(
                          values['re-enter-email'] as String,
                          values['new-password'] as String,
                        );
                  }
                },
          child: const Text('Update Password'),
        ),
      ],
    );
  }
}
