import 'package:flutter/material.dart';
import 'package:portal/ui/auth/screens/forgot_password_screen.dart';
import 'package:portal/ui/auth/screens/landing_screen.dart';
import 'package:portal/ui/auth/screens/otp_verification_screen.dart';
import 'package:portal/ui/auth/screens/reset_password_screen.dart';
import 'package:portal/ui/auth/screens/signin_screen.dart';
import 'package:portal/ui/auth/screens/signup_screen.dart';
import 'package:portal/ui/navigation/screens/navigation_screen.dart';

/// Defines route names and maps them to builder functions.
/// Example usage:
///   Navigator.pushNamed(context, AppRoutes.signIn.name);
enum AppRoutes {
  none('/none'),
  home('/'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  forgetPassword('/forget-password'),
  otpVerification('/otp-verification'),
  resetPassword('/reset-password'),
  navigation('/navigation');

  final String name;
  const AppRoutes(this.name);
}

Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.home.name: (_) => const LandingScreen(),
  AppRoutes.signIn.name: (_) => const SignInScreen(),
  AppRoutes.signUp.name: (_) => const SignUpScreen(),
  AppRoutes.forgetPassword.name: (_) => const ForgotPasswordScreen(),
  AppRoutes.otpVerification.name: (_) => const OTPVerificationScreen(),
  AppRoutes.resetPassword.name: (_) => const ResetPasswordScreen(),
  AppRoutes.navigation.name: (_) => const NavigationScreen(),
};
