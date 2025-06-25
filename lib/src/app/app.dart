import 'package:flutter/material.dart';
import 'package:portal/src/presentation/auth/presentation/landing_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: ShadColorScheme.fromName(
          'green',
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadColorScheme.fromName(
          'green',
          brightness: Brightness.dark,
        ),
      ),
      appBuilder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          builder: (context, child) {
            return ShadAppBuilder(child: child!);
          },
          home: LandingPage(),
        );
      },
    );
  }
}
