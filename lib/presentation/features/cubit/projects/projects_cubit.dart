import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsCubitState> {
  ProjectsCubit({required BaseProjectRepo projectRepo})
      : _projectRepo = projectRepo,
        super(const ProjectsCubitState.initial());

  final BaseProjectRepo _projectRepo;

  Future<void> fetchProjects() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _projectRepo.getProjects();
    result.when(
      success: (projects) {
        emit(state.copyWith(
          cubitStatus: CubitStatus.success,
          projects: projects,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          cubitStatus: CubitStatus.error,
          appErrorModel: error,
        ));
      },
    );
  }
}
