import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portal/config/app_configs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  // Seed colors.
  static Color primarySeedColor = AppConfigs.primary;
  static Color secondarySeedColor = AppConfigs.secondary;
  static Color tertiarySeedColor = AppConfigs.tertiary;

  // Make a light ColorScheme from the seeds.
  static final defaultLightColorScheme = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: primarySeedColor,
    secondaryKey: secondarySeedColor,
    tertiaryKey: tertiarySeedColor,
    tones: FlexTones.vivid(Brightness.light),
  );

  // Make a dark ColorScheme from the same seed colors.
  static final defaultDarkColorScheme = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: primarySeedColor,
    secondaryKey: secondarySeedColor,
    tertiaryKey: tertiarySeedColor,
    tones: FlexTones.vivid(Brightness.dark),
  );

  static ThemeData buildMaterialTheme(
    ColorScheme colorScheme,
    Brightness brightness,
  ) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: colorScheme.surface,
          systemNavigationBarIconBrightness: isDark
              ? Brightness.light
              : Brightness.dark,
        ),
      ),
    );
  }

  // Helper method to create ShadColorScheme from Material ColorScheme
  static ShadColorScheme buildShadColorSchemeFromMaterial(
    ColorScheme materialColorScheme,
    Brightness brightness,
  ) {
    return ShadColorScheme(
      background: materialColorScheme.surface,
      foreground: materialColorScheme.onSurface,
      card: materialColorScheme.surfaceContainerLow,
      cardForeground: materialColorScheme.onSurface,
      popover: materialColorScheme.surfaceContainerLow,
      popoverForeground: materialColorScheme.onSurface,
      primary: materialColorScheme.primary,
      primaryForeground: materialColorScheme.onPrimary,
      secondary: materialColorScheme.secondary,
      secondaryForeground: materialColorScheme.onSecondary,
      muted: materialColorScheme.surfaceContainerHigh,
      mutedForeground: materialColorScheme.onSurfaceVariant,
      accent: materialColorScheme.secondaryContainer,
      accentForeground: materialColorScheme.onSecondaryContainer,
      destructive: materialColorScheme.error,
      destructiveForeground: materialColorScheme.onError,
      border: materialColorScheme.outlineVariant,
      input: materialColorScheme.surfaceContainerLowest,
      ring: materialColorScheme.primary,
      selection: materialColorScheme.primary.withAlpha(20),
    );
  }
}
