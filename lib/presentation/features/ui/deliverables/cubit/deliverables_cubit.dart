import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/presentation/features/ui/deliverables/cubit/deliverables_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliverablesCubit extends Cubit<DeliverablesState> {
  DeliverablesCubit({required BaseDeliverablesRepo deliverablesRepo})
    : _deliverablesRepo = deliverablesRepo,
      super(const DeliverablesState());

  final BaseDeliverablesRepo _deliverablesRepo;

  Future<void> fetchDeliverables() async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deliverablesRepo.getDeliverables();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            blueprints: data.blueprints,
            renders: data.renders,
            walkthroughs: data.walkthroughs,
            projectName: data.projectName,
            projectThumbnailUrl: data.projectThumbnailUrl,
            allFilesZipUrl: data.allFilesZipUrl,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }
}
