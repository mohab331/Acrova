import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class ProjectsCubitState extends Equatable {
  const ProjectsCubitState({
    required this.cubitStatus,
    this.projects,
    this.appErrorModel,
  });

  const ProjectsCubitState.initial()
      : this(cubitStatus: CubitStatus.initial);

  final CubitStatus cubitStatus;
  final List<ProjectModel>? projects;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  ProjectsCubitState copyWith({
    CubitStatus? cubitStatus,
    List<ProjectModel>? projects,
    AppErrorModel? appErrorModel,
  }) =>
      ProjectsCubitState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        projects: projects ?? this.projects,
        appErrorModel: appErrorModel ?? this.appErrorModel,
      );

  @override
  List<Object?> get props => [cubitStatus, projects, appErrorModel];
}
