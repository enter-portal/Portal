import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/src/app/config/routes.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_layout.dart';
import 'package:portal/src/presentation/auth/presentation/widgets/responsive_spacer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OTPVerificationPage extends HookConsumerWidget {
  final AppRoutes previousPage;
  const OTPVerificationPage({super.key, this.previousPage = AppRoutes.none});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define formKey inside the build method using useRef
    final formKey = useRef(GlobalKey<ShadFormState>());

    return AuthLayout(
      title: 'OTP Verification',
      // Access the current value of the useRef hook
      formKey: formKey.value,
      children: [
        ShadInputOTPFormField(
          id: 'otp',
          maxLength: 4,
          label: const Text('One Time Password'),
          description: const Text('Enter the OTP sent to your email.'),
          validator: (v) {
            if (v.contains(' ') || v.length < 4) {
              // Added null check and length check
              return 'Please enter a valid 4-digit OTP';
            }
            return null;
          },
          children: const [
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            Icon(size: 25, LucideIcons.dot),
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            Icon(size: 25, LucideIcons.dot),
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            Icon(size: 25, LucideIcons.dot),
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
          ],
        ),
        ResponsiveSpacer(),
        ShadAlert(
          iconData: LucideIcons.info,
          title: Text('Heads up!'),
          description: Text(
            'Please check your email for the OTP code. It might take a few minutes to arrive.',
          ),
        ),
        const SizedBox(height: 15),
        ShadButton(
          width: double.infinity,
          child: const Text('Verify OTP'),
          onPressed: () {
            // Access the current value of the useRef hook
            if (formKey.value.currentState!.saveAndValidate()) {
              print(
                'validation succeeded with ${formKey.value.currentState!.value}',
              );

              switch (previousPage) {
                case AppRoutes.signUp:
                  print('redirect to home');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home.name,
                    (Route<dynamic> route) => false,
                  ); // This removes all routes
                  break;
                case AppRoutes.forgetPassword:
                  print('redirect to forget password');
                  Navigator.pushNamed(
                    context,
                    AppRoutes.resetPassword.name,
                  ); // This removes all routes
                  break;
                default:
                  print('error');
              }
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
