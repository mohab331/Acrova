import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsCubitState> {
  ProjectsCubit({
    required BaseProjectRepo projectRepo,
    BaseAuthRepo? authRepo,
  })  : _projectRepo = projectRepo,
        _authRepo = authRepo,
        super(const ProjectsCubitState.initial());

  final BaseProjectRepo _projectRepo;
  final BaseAuthRepo? _authRepo;

  Future<void> fetchProjects() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    if (_authRepo != null) {
      final profileResult = await _authRepo.getUserProfile();
      profileResult.when(
        success: (profile) {
          emit(state.copyWith(
            userName: profile.name.isNotEmpty ? profile.name : 'Client',
            avatarUrl: profile.avatarUrl,
          ));
        },
        failure: (_) {},
      );
    }

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
