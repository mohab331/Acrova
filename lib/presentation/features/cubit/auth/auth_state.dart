import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';


class AuthCubitState extends Equatable {
  const AuthCubitState({
    required this.cubitStatus,
    required this.appErrorModel,
  });

  const AuthCubitState.initial()
    : this(
        cubitStatus: CubitStatus.initial,
        appErrorModel: null,
      );
  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;

  bool get isSuccess => cubitStatus == CubitStatus.success;

  bool get isError => cubitStatus == CubitStatus.error;

  bool get isAuthorized =>
      cubitStatus == CubitStatus.success;

  AuthCubitState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
  }) => AuthCubitState(
    appErrorModel: appErrorModel,
    cubitStatus: cubitStatus ?? this.cubitStatus,
  );

  @override
  List<Object?> get props => [cubitStatus, appErrorModel,];
}
