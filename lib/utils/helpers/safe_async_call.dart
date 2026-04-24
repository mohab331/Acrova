import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/logging/app_logger.dart';

/// Executes an async [function] and wraps its outcome in a `Result<T>`.
///
/// - On success → returns `Success<T>(value)`.
/// - On error   → returns `Failure<T>(AppErrorModel<T>)`, optionally carrying
///   [defaultDataOnError] so callers still get fallback data with the error.
///
/// Useful to centralize try/catch and exception→error-model mapping.
///
/// Type params:
/// - `T`: the value type produced by [function].
///
/// Params:
/// - [function]: zero-arg async operation to execute.
/// - [defaultDataOnError]: optional fallback data attached to the failure.
///
/// Example:
/// ```dart
/// Future<Result<User>> fetchMe() => safeAsyncCall<User>(() async {
///   final res = await dio.get('/me');
///   return User.fromJson(res.data);
/// }, defaultDataOnError: User.empty());
/// ```
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

/// For non async
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
