import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/routing/routes.dart';
import 'package:portal/ui/core/themes/app_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder:
          (
            ColorScheme? lightDynamicColorScheme,
            ColorScheme? darkDynamicColorScheme,
          ) {
            final lightColorScheme =
                lightDynamicColorScheme ?? AppTheme.defaultLightColorScheme;

            final darkColorScheme =
                darkDynamicColorScheme ?? AppTheme.defaultDarkColorScheme;

            return ShadApp.custom(
              theme: ShadThemeData(
                brightness: Brightness.light,
                colorScheme: AppTheme.buildShadColorSchemeFromMaterial(
                  lightColorScheme,
                  Brightness.light,
                ),
              ),
              darkTheme: ShadThemeData(
                brightness: Brightness.dark,
                colorScheme: AppTheme.buildShadColorSchemeFromMaterial(
                  darkColorScheme,
                  Brightness.dark,
                ),
              ),
              appBuilder: (context) {
                return MaterialApp(
                  debugShowCheckedModeBanner: AppConfigs.debugMode,
                  title: AppConfigs.appName,
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
                  routes: appRoutes,
                  initialRoute: AppRoutes.home.name,
                );
              },
            );
          },
    );
  }
}
