import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/widgets/auth_layout.dart';
import 'package:portal/ui/auth/view_models/auth_viewmodel.dart';
import 'package:portal/ui/auth/providers/auth_provider.dart';
import 'package:portal/routing/routes.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OTPVerificationScreen extends HookConsumerWidget {
  final AppRoutes previousPage;
  final String email;

  const OTPVerificationScreen({
    super.key,
    this.previousPage = AppRoutes.none,
    this.email = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final formKey = useRef(GlobalKey<ShadFormState>());

    ref.listen<AuthState>(authViewModelProvider, (_, next) {
      if (next is AuthInitial) {
        switch (previousPage) {
          case AppRoutes.signUp:
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.navigation.name,
              (_) => false,
            );
          case AppRoutes.forgetPassword:
            Navigator.pushNamed(context, AppRoutes.resetPassword.name);
          default:
            break;
        }
      } else if (next is AuthError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('OTP Error'),
            description: Text(next.message),
          ),
        );
        ref.read(authViewModelProvider.notifier).clearError();
      }
    });

    final isLoading = ref.watch(authViewModelProvider) is AuthLoading;

    return AuthLayout(
      title: 'Enter verification code',
      isLoading: isLoading,
      formKey: formKey.value,
      showBackButton: true,
      onBack: () => Navigator.pop(context),
      children: [
        const SizedBox(height: 8),
        Text(
          'We sent a 4-digit code to your email address.',
          style: theme.textTheme.muted,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Center(
          child: ShadInputOTPFormField(
            id: 'otp',
            maxLength: 4,
            validator: (v) {
              if (v.contains(' ') || v.length < 4) {
                return 'Please enter a valid 4-digit code';
              }
              return null;
            },
            children: const [
              ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
              ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
              ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
              ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            ],
          ),
        ),
        const SizedBox(height: 32),
        ShadButton(
          size: ShadButtonSize.lg,
          onPressed: isLoading
              ? null
              : () {
                  if (formKey.value.currentState!.saveAndValidate()) {
                    final values = formKey.value.currentState!.value;
                    ref
                        .read(authViewModelProvider.notifier)
                        .verifyOtp(email, values['otp'] as String);
                  }
                },
          child: const Text('Verify'),
        ),
        const SizedBox(height: 16),
        ShadButton.link(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text('Resend Code'),
          onPressed: () => {
            // Logic to resend OTP
          },
        ),
      ],
    );
  }
}
