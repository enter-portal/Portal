import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/widgets/auth_layout.dart';
import 'package:portal/ui/auth/view_models/auth_viewmodel.dart';
import 'package:portal/ui/auth/providers/auth_provider.dart';
import 'package:portal/ui/auth/screens/otp_verification_screen.dart';
import 'package:portal/routing/routes.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    ref.listen<AuthState>(authViewModelProvider, (_, next) {
      if (next is AuthInitial) {
        final values = formKey.currentState?.value ?? {};
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerificationScreen(
              previousPage: AppRoutes.forgetPassword,
              email: values['email'] as String? ?? '',
            ),
          ),
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
      onBack: () => Navigator.pop(context),
      children: [
        const SizedBox(height: 8),
        Text(
          'Enter your email address and \n we\'ll send you a code to reset your password.',
          style: theme.textTheme.muted,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ShadInputFormField(
          id: 'email',
          leading: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(LucideIcons.mail, size: 18),
          ),
          placeholder: const Text('Email'),
          keyboardType: TextInputType.emailAddress,
          validator: (v) => v.isEmpty ? 'Email is required' : null,
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
                        .forgotPassword(values['email'] as String);
                  }
                },
          child: const Text('Reset Password'),
        ),
      ],
    );
  }
}
