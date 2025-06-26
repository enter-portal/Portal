import 'package:flutter/material.dart';
import 'package:portal/src/presentation/auth/presentation/forget_password_page.dart';
import 'package:portal/src/presentation/auth/presentation/landing_page.dart';
import 'package:portal/src/presentation/auth/presentation/otp_verification_page.dart';
import 'package:portal/src/presentation/auth/presentation/reset_password_page.dart';
import 'package:portal/src/presentation/auth/presentation/signin_page.dart';
import 'package:portal/src/presentation/auth/presentation/signup_page.dart';
import 'package:portal/src/presentation/navigation/presentation/navigation_page.dart';

enum AppRoutes {
  none(''),
  home('/'),
  signIn('/sign_in'),
  signUp('/sign_up'),
  forgetPassword('/forget_password'),
  otpVerification('/otp_verification'),
  resetPassword('/reset_password'),
  navigation('/navigation');

  final String name;
  const AppRoutes(this.name);
}

class Routes {
  final Map<String, WidgetBuilder> _routes;

  Routes(BuildContext context)
    : _routes = <String, WidgetBuilder>{
        AppRoutes.home.name: (context) => LandingPage(),
        AppRoutes.signIn.name: (context) => SignInPage(),
        AppRoutes.signUp.name: (context) => SignUpPage(),
        AppRoutes.forgetPassword.name: (context) => ForgetPasswordPage(),
        AppRoutes.otpVerification.name: (context) => OTPVerificationPage(),
        AppRoutes.resetPassword.name: (context) => ResetPasswordPage(),
        AppRoutes.navigation.name: (context) => NavigationPage(),
      };

  Map<String, WidgetBuilder> getRoutes() => _routes;
}
