import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:bloc/bloc.dart';

import 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsCubitState> {
  ProjectsCubit({required BaseProjectRepo projectRepo, BaseAuthRepo? authRepo})
    : _projectRepo = projectRepo,
      _authRepo = authRepo,
      super(const ProjectsCubitState.initial());

  final BaseProjectRepo _projectRepo;
  final BaseAuthRepo? _authRepo;

  Future<void> fetchProjects() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    if (_authRepo != null) {
      await safeAsync(
        operation: () async {
          final profileResult = await _authRepo.getUserProfile();
          profileResult.when(
            success: (profile) {
              emit(
                state.copyWith(
                  userName: profile.name.isNotEmpty ? profile.name : null,
                  avatarUrl: profile.avatarUrl,
                ),
              );
            },
            failure: (error) {
              AppLogger.instance.logWarning(
                'Failed to load profile in ProjectsCubit: ${error.message}',
              );
            },
          );
        },
        onError: (error) {
          AppLogger.instance.logWarning(
            'Exception loading profile in ProjectsCubit: ${error.message}',
          );
        },
      );
    }

    await safeCubitCall<List<ProjectModel>>(
      call: _projectRepo.getProjects,
      onSuccess: (projects) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.success, projects: projects),
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
