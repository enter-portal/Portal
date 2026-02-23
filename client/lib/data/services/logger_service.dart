import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

/// Shared logger instance. Use [loggerProvider] in Riverpod widgets/notifiers,
/// or import [appLogger] directly in non-Riverpod code.
final Logger appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    lineLength: 100,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

/// Riverpod provider for the logger.
final loggerProvider = Provider<Logger>((ref) => appLogger);
