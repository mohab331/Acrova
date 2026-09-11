import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/features/cubit/project_detail/project_detail_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailCubit extends Cubit<ProjectDetailState> {
  ProjectDetailCubit({
    required BaseProjectRepo projectRepo,
  })  : _projectRepo = projectRepo,
        super(const ProjectDetailState());

  final BaseProjectRepo _projectRepo;

  Future<void> fetchProject(String projectId) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final result = await _projectRepo.getProject(projectId);

    result.when(
      success: (project) {
        emit(
          state.copyWith(
            cubitStatus: CubitStatus.success,
            project: project,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            cubitStatus: CubitStatus.error,
            appErrorModel: error,
          ),
        );
      },
    );
  }
}
