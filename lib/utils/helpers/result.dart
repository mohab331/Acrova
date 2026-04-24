

import 'package:acrova/core/error/app_error_model.dart';

sealed class Result<T> {
  const Result();
  R when<R>({
    required final R Function(T data) success,
    required final R Function(AppErrorModel error) failure,
  });
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
  @override
  R when<R>({
    required final R Function(T data) success,
    required final R Function(AppErrorModel error) failure,
  }) => success(data);
}

class Failure<T> extends Result<T> {
  const Failure(this.error);
  final AppErrorModel error;
  @override
  R when<R>({
    required final R Function(T data) success,
    required final R Function(AppErrorModel error) failure,
  }) => failure(error);
}