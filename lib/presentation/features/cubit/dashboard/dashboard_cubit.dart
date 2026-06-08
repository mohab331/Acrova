import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardCubitState> {
  DashboardCubit({required BaseProjectRepo projectRepo})
      : _projectRepo = projectRepo,
        super(const DashboardCubitState.initial());

  final BaseProjectRepo _projectRepo;

  Future<void> fetchDashboardData() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _projectRepo.getDashboard();
    result.when(
      success: (data) {
        emit(state.copyWith(
          cubitStatus: CubitStatus.success,
          data: data,
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
