import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/widgets/auth_layout.dart';
import 'package:portal/ui/auth/view_models/auth_viewmodel.dart';
import 'package:portal/ui/auth/providers/auth_provider.dart';
import 'package:portal/ui/auth/screens/otp_verification_screen.dart';
import 'package:portal/routing/routes.dart';
import 'package:portal/ui/core/ui/password_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    ref.listen<AuthState>(authViewModelProvider, (_, next) {
      if (next is AuthAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const OTPVerificationScreen(previousPage: AppRoutes.signUp),
          ),
        );
      } else if (next is AuthError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Sign Up Failed'),
            description: Text(next.message),
          ),
        );
        ref.read(authViewModelProvider.notifier).clearError();
      }
    });

    final isLoading = ref.watch(authViewModelProvider) is AuthLoading;

    return AuthLayout(
      title: 'Sign Up',
      isLoading: isLoading,
      formKey: formKey,
      children: [
        ShadInputFormField(
          id: 'username',
          leading: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(LucideIcons.user, size: 18),
          ),
          placeholder: const Text('Username'),
          keyboardType: TextInputType.name,
          validator: (v) => v.isEmpty ? 'Username is required' : null,
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
        PasswordInput(id: 'password', placeholder: const Text('Password')),
        const SizedBox(height: 24),
        ShadButton(
          width: double.infinity,
          size: ShadButtonSize.lg,
          onPressed: isLoading
              ? null
              : () {
                  if (formKey.currentState!.saveAndValidate()) {
                    final values = formKey.currentState!.value;
                    ref
                        .read(authViewModelProvider.notifier)
                        .signUp(
                          username: values['username'] as String,
                          email: values['email'] as String,
                          password: values['password'] as String,
                        );
                  }
                },
          child: const Text('Sign Up'),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?", style: theme.textTheme.muted),
            ShadButton.link(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Text('Sign In'),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.signIn.name),
            ),
          ],
        ),
      ],
    );
  }
}
