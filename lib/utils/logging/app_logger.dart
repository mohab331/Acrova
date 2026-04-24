import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger instance = AppLogger._internal();

  AppLogger._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(lineLength: 90, methodCount: 0),
  );

  void logInfo(final String message) => _logger.i(message);

  void logDebug(final String message) => _logger.d(message);

  void logWarning(final String message) => _logger.w(message);

  void logError(final String message, {final Object? error, final StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  void logTrace(final String message) => _logger.t(message);
}
