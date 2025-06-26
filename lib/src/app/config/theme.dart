import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portal/src/app/config/constants.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  // Seed colors.
  static Color primarySeedColor = AppConstants.primary;
  static Color secondarySeedColor = AppConstants.secondary;
  static Color tertiarySeedColor = AppConstants.tertiary;

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
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorScheme.surface,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: colorScheme.surface,
          systemNavigationBarIconBrightness:
              isDark ? Brightness.light : Brightness.dark,
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
      card: materialColorScheme.surfaceContainer,
      cardForeground: materialColorScheme.onSurface,
      popover: materialColorScheme.surfaceContainer,
      popoverForeground: materialColorScheme.onSurface,
      primary: materialColorScheme.primary,
      primaryForeground: materialColorScheme.onPrimary,
      secondary: materialColorScheme.secondary,
      secondaryForeground: materialColorScheme.onSecondary,
      muted: materialColorScheme.surfaceContainerHighest,
      mutedForeground: materialColorScheme.onSurfaceVariant,
      accent: materialColorScheme.tertiary,
      accentForeground: materialColorScheme.onTertiary,
      destructive: materialColorScheme.error,
      destructiveForeground: materialColorScheme.onError,
      border: materialColorScheme.outline,
      input: materialColorScheme.surfaceContainerHighest,
      ring: materialColorScheme.primary,
      selection: materialColorScheme.primary.withAlpha(2),
    );
  }
}
