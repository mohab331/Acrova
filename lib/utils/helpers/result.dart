import 'package:acrova/core/error/app_error_model.dart';

sealed class Result<T> {
  const Result();
  R when<R>({
    required final R Function(T data) success,
    required final R Function(AppErrorModel error) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  AppErrorModel? get errorOrNull =>
      this is Failure<T> ? (this as Failure<T>).error : null;
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
