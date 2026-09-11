import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/logging/app_logger.dart';

/// Executes an async [function] and wraps its outcome in a `Result<T>`.
///
/// - On success → returns `Success<T>(value)`.
/// - On error   → returns `Failure<T>(AppErrorModel<T>)`, optionally carrying
///   [defaultDataOnError] so callers still get fallback data with the error.
Future<Result<T>> safeAsyncCall<T>(
  final Future<T> Function() function, {
  final T? defaultDataOnError,
}) async {
  try {
    final result = await function();
    return Success(result);
  } catch (e, s) {
    AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    return Failure(
      e is AppErrorModel
          ? e
          : AppErrorModel<T>.fromException(
              e,
              stackTrace: s,
              data: defaultDataOnError,
            ),
    );
  }
}

/// For non-async operations returning a `Result<T>`.
Result<T> safeCall<T>(
  final T Function() function, {
  final T? defaultDataOnError,
}) {
  try {
    final result = function();
    return Success(result);
  } catch (e, s) {
    AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    return Failure(
      e is AppErrorModel
          ? e
          : AppErrorModel<T>.fromException(
              e,
              stackTrace: s,
              data: defaultDataOnError,
            ),
    );
  }
}

/// Standard async wrapper for Cubits to execute async business operations safely.
///
/// Automatically handles try/catch and guarantees [onError] is called with an [AppErrorModel]
/// if an uncaught exception is thrown.
Future<void> safeAsync({
  required Future<void> Function() operation,
  required void Function(AppErrorModel error) onError,
}) async {
  try {
    await operation();
  } catch (e, s) {
    AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    final error = e is AppErrorModel
        ? e
        : AppErrorModel.fromException(e, stackTrace: s);
    onError(error);
  }
}

/// Helper for Cubits calling repository methods that return `Result<T>`.
///
/// Catches unexpected exceptions, unwraps the `Result`, and safely dispatches to
/// [onSuccess] or [onError].
Future<void> safeCubitCall<T>({
  required Future<Result<T>> Function() call,
  required void Function(T data) onSuccess,
  required void Function(AppErrorModel error) onError,
}) async {
  try {
    final result = await call();
    result.when(success: onSuccess, failure: onError);
  } catch (e, s) {
    AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    final error = e is AppErrorModel
        ? e
        : AppErrorModel.fromException(e, stackTrace: s);
    onError(error);
  }
}
