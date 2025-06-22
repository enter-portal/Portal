import 'package:flutter/material.dart';
import 'package:portal/src/presentation/landing_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: ShadColorScheme.fromName(
          'zinc',
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadColorScheme.fromName(
          'zinc',
          brightness: Brightness.dark,
        ),
      ),
      home: LandingPage(),
    );
  }
}
