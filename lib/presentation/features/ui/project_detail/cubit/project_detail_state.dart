import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class ProjectDetailState extends Equatable {
  const ProjectDetailState({
    this.cubitStatus = CubitStatus.initial,
    this.projectId,
    this.appErrorModel,
    this.project,
  });

  final CubitStatus cubitStatus;
  final String? projectId;
  final AppErrorModel? appErrorModel;
  final ProjectModel? project;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  ProjectDetailState copyWith({
    CubitStatus? cubitStatus,
    String? projectId,
    AppErrorModel? appErrorModel,
    ProjectModel? project,
  }) {
    return ProjectDetailState(
      cubitStatus: cubitStatus ?? this.cubitStatus,
      projectId: projectId ?? this.projectId,
      appErrorModel: appErrorModel ?? this.appErrorModel,
      project: project ?? this.project,
    );
  }

  @override
  List<Object?> get props => [cubitStatus, projectId, appErrorModel, project];
}
