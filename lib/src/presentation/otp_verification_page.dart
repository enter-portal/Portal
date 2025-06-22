import 'package:flutter/material.dart';
import 'package:portal/src/presentation/reset_password_page.dart';
import 'package:portal/src/presentation/widgets/layouts/auth_page_layout.dart';
import 'package:portal/src/presentation/widgets/responsive_spacer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: 'OTP Verification',
      formKey: formKey,
      children: [
        ShadInputOTPFormField(
          id: 'otp',
          maxLength: 4,
          label: const Text('One Time Password'),
          description: const Text('Enter the OTP sent to your email.'),
          validator: (v) {
            if (v.contains(' ')) {
              return 'Fill the whole OTP code';
            }
            return null;
          },
          children: const [
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            Icon(size: 24, LucideIcons.dot),
            ShadInputOTPGroup(children: [ShadInputOTPSlot()]),
            Icon(size: 24, LucideIcons.dot),
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
            if (formKey.currentState!.saveAndValidate()) {
              print('validation succeeded with ${formKey.currentState!.value}');
            } else {
              print('validation failed');
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
