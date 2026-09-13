import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/features/ui/project_detail/cubit/project_detail_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
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

    final result = await _projectRepo.getProject(id);
    result.when(
      success: (data) {
        emit(state.copyWith(cubitStatus: CubitStatus.success, project: data));
      },
      failure: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }
}
