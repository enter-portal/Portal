import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/ui/auth/widgets/auth_layout.dart';
import 'package:portal/ui/auth/view_models/auth_viewmodel.dart';
import 'package:portal/ui/auth/providers/auth_provider.dart';
import 'package:portal/routing/routes.dart';
import 'package:portal/ui/core/ui/password_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    ref.listen<AuthState>(authViewModelProvider, (_, next) {
      if (next is AuthAuthenticated) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.navigation.name,
          (_) => false,
        );
      } else if (next is AuthError) {
        ShadToaster.of(context).show(
          ShadToast.destructive(
            title: const Text('Sign In Failed'),
            description: Text(next.message),
          ),
        );
        ref.read(authViewModelProvider.notifier).clearError();
      }
    });

    final isLoading = ref.watch(authViewModelProvider) is AuthLoading;

    return AuthLayout(
      title: 'Sign In',
      isLoading: isLoading,
      formKey: formKey,
      children: [
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
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ShadButton.link(
            padding: EdgeInsets.zero,
            child: const Text('Forgot Password?'),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.forgetPassword.name),
          ),
        ),
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
                        .signIn(
                          values['email'] as String,
                          values['password'] as String,
                        );
                  }
                },
          child: const Text('Sign In'),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?", style: theme.textTheme.muted),
            ShadButton.link(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Text('Sign Up'),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.signUp.name),
            ),
          ],
        ),
      ],
    );
  }
}
