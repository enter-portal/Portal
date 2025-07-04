import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/material.dart';
import 'package:portal/src/app/config/constants.dart';
import 'package:portal/src/app/config/routes.dart';
import 'package:portal/src/app/config/theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (
        ColorScheme? lightDynamicColorScheme,
        ColorScheme? darkDynamicColorScheme,
      ) {
        // Get the actual color schemes to use
        final lightColorScheme =
            lightDynamicColorScheme ?? AppTheme.defaultLightColorScheme;

        final darkColorScheme =
            darkDynamicColorScheme ?? AppTheme.defaultDarkColorScheme;

        return ShadApp.custom(
          // Apply light dynamic colors to Shadcn UI
          theme: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: AppTheme.buildShadColorSchemeFromMaterial(
              lightColorScheme,
              Brightness.light,
            ),
          ),
          // Apply dark dynamic colors to Shadcn UI
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: AppTheme.buildShadColorSchemeFromMaterial(
              darkColorScheme,
              Brightness.dark,
            ),
          ),
          appBuilder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: AppConstants.debugMode,
              title: AppConstants.appName,
              theme: AppTheme.buildMaterialTheme(
                lightColorScheme,
                Brightness.light,
              ),
              darkTheme: AppTheme.buildMaterialTheme(
                darkColorScheme,
                Brightness.dark,
              ),
              themeMode: ThemeMode.system,
              builder: (context, child) {
                return ShadAppBuilder(child: child!);
              },
              routes: Routes(context).getRoutes(),
              initialRoute: AppRoutes.home.name,
            );
          },
        );
      },
    );
  }
}
