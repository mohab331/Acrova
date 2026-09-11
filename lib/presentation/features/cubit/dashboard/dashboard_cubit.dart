import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:bloc/bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardCubitState> {
  DashboardCubit({required BaseProjectRepo projectRepo})
    : _projectRepo = projectRepo,
      super(const DashboardCubitState.initial());

  final BaseProjectRepo _projectRepo;

  Future<void> fetchDashboardData() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    await safeCubitCall<DashboardDataModel>(
      call: _projectRepo.getDashboard,
      onSuccess: (data) {
        emit(state.copyWith(cubitStatus: CubitStatus.success, data: data));
      },
      onError: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }
}
