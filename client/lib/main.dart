import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/data/services/isar_database.dart';
import 'package:portal/ui/core/app.dart';
import 'package:portal/utils/window_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDesktopWindow();

  // Isar requires at least one @Collection schema to open.
  // Steps to enable real Isar DB:
  //   1. Un-comment part directives in user_collection.dart & message_collection.dart
  //   2. Run: flutter pub run build_runner build
  //   3. Add schema refs to IsarDatabase.open() in isar_database.dart
  //   4. Set AppConfigs.useFakeNetwork = false
  if (AppConfigs.useFakeNetwork) {
    // Skip Isar when using fake repos — no schemas are registered yet.
    runApp(const ProviderScope(child: App()));
  } else {
    final isar = await IsarDatabase.open();
    runApp(
      ProviderScope(
        overrides: [isarProvider.overrideWithValue(isar)],
        child: const App(),
      ),
    );
  }
}
