import 'dart:ui';

class AppConfigs {
  // App info
  static const String appName = 'Portal';
  static const String appLogo = 'assets/images/svg/portal_1.svg';

  // App Colors — Signal-inspired palette
  static const Color primary = Color(0xFF2C6BED); // Signal Primary Blue
  static const Color secondary = Color(0xFF1B2B41); // Deep Navy for contrast
  static const Color tertiary = Color(0xFF1A85FF); // Bright Accent Blue

  // App Debug Mode
  static const bool debugMode = false;

  // Network — replace with real URLs when backend is ready
  static const String baseUrl = 'https://api.portal.example.com/v1';
  static const String socketUrl = 'https://api.portal.example.com';

  /// When true the data layer uses fake repos with timer-based delays.
  /// Flip to false to switch to real Dio + socket calls.
  static const bool useFakeNetwork = true;

  // Timing constants for fake network simulation
  static const Duration fakeShortDelay = Duration(milliseconds: 600);
  static const Duration fakeMediumDelay = Duration(milliseconds: 1000);
  static const Duration fakeLongDelay = Duration(milliseconds: 1500);
}
