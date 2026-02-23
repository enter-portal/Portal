import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portal/data/services/logger_service.dart';

// TODO: Re-create Isar collections under core/database/collections/ when needed.
// import 'package:portal/src/core/database/collections/user_collection.dart';
// import 'package:portal/src/core/database/collections/message_collection.dart';

/// Opens and provides the single shared [Isar] instance.
///
/// Call [IsarDatabase.open] before [runApp] and inject the result into
/// [ProviderScope] via `overrides:`.
class IsarDatabase {
  static Isar? _instance;

  static Isar get instance {
    assert(
      _instance != null,
      'IsarDatabase.open() must be called before accessing the instance.',
    );
    return _instance!;
  }

  static Future<Isar> open() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      // TODO: Add collection schemas once recreated.
      [],
      directory: dir.path,
      inspector:
          true, // Only active in debug. Shows Isar Inspector in DevTools.
    );
    appLogger.i('📦 Isar DB opened at ${dir.path}');
    return _instance!;
  }

  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
    appLogger.i('📦 Isar DB closed');
  }
}

/// Riverpod provider that expects the [Isar] instance to be injected
/// via an override in main.dart after [IsarDatabase.open()].
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'isarProvider must be overridden in ProviderScope after IsarDatabase.open()',
  );
});
