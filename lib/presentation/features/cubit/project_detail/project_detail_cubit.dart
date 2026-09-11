import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/features/cubit/project_detail/project_detail_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailCubit extends Cubit<ProjectDetailState> {
  ProjectDetailCubit({required BaseProjectRepo projectRepo})
    : _projectRepo = projectRepo,
      super(const ProjectDetailState());

  final BaseProjectRepo _projectRepo;

  Future<void> fetchProject([String? projectId]) async {
    final id = projectId ?? state.projectId;
    if (id == null || id.isEmpty) return;

    emit(state.copyWith(cubitStatus: CubitStatus.loading, projectId: id));

    await safeCubitCall<ProjectModel>(
      call: () => _projectRepo.getProject(id),
      onSuccess: (project) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.success, project: project),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }
}
