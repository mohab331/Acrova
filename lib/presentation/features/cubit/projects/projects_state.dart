import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class ProjectsCubitState extends Equatable {
  const ProjectsCubitState({
    required this.cubitStatus,
    this.projects,
    this.appErrorModel,
    this.userName,
    this.notificationCount = 0,
    this.avatarUrl,
  });

  const ProjectsCubitState.initial() : this(cubitStatus: CubitStatus.initial);

  final CubitStatus cubitStatus;
  final List<ProjectModel>? projects;
  final AppErrorModel? appErrorModel;
  final String? userName;
  final int notificationCount;
  final String? avatarUrl;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  ProjectsCubitState copyWith({
    CubitStatus? cubitStatus,
    List<ProjectModel>? projects,
    AppErrorModel? appErrorModel,
    String? userName,
    int? notificationCount,
    String? avatarUrl,
  }) => ProjectsCubitState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    projects: projects ?? this.projects,
    appErrorModel: appErrorModel ?? this.appErrorModel,
    userName: userName ?? this.userName,
    notificationCount: notificationCount ?? this.notificationCount,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );

  @override
  List<Object?> get props => [
    cubitStatus,
    projects,
    appErrorModel,
    userName,
    notificationCount,
    avatarUrl,
  ];
}
