import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class DashboardCubitState extends Equatable {
  const DashboardCubitState({
    required this.cubitStatus,
    this.data,
    this.appErrorModel,
  });

  const DashboardCubitState.initial()
      : this(
          cubitStatus: CubitStatus.initial,
          data: null,
          appErrorModel: null,
        );

  final CubitStatus cubitStatus;
  final DashboardDataModel? data;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  DashboardCubitState copyWith({
    CubitStatus? cubitStatus,
    DashboardDataModel? data,
    AppErrorModel? appErrorModel,
  }) =>
      DashboardCubitState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        data: data ?? this.data,
        appErrorModel: appErrorModel ?? this.appErrorModel,
      );

  @override
  List<Object?> get props => [cubitStatus, data, appErrorModel];
}
