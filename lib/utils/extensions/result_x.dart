import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/helpers/result.dart';

extension ResultX<T> on Result<T> {
  T? get dataOrNull => when(success: (data) => data, failure: (_) => null);

  AppErrorModel? get errorOrNull =>
      when(success: (_) => null, failure: (error) => error);

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T getOrThrow() =>
      when(success: (data) => data, failure: (error) => throw error);

  T getOrDefault(T fallback) =>
      when(success: (data) => data, failure: (_) => fallback);
}
