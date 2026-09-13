import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class DashboardCubitState extends Equatable {
  const DashboardCubitState({required this.cubitStatus, this.appErrorModel});

  const DashboardCubitState.initial()
    : this(cubitStatus: CubitStatus.initial, appErrorModel: null);

  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  DashboardCubitState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
  }) => DashboardCubitState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    appErrorModel: appErrorModel ?? this.appErrorModel,
  );

  @override
  List<Object?> get props => [cubitStatus, appErrorModel];
}
