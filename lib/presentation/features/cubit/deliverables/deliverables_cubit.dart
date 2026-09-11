import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliverablesCubit extends Cubit<DeliverablesState> {
  DeliverablesCubit({required BaseDeliverablesRepo deliverablesRepo})
    : _deliverablesRepo = deliverablesRepo,
      super(const DeliverablesState());

  final BaseDeliverablesRepo _deliverablesRepo;

  Future<void> fetchDeliverables() async {
    emit(state.copyWith(status: CubitStatus.loading));

    await safeCubitCall<DeliverablesData>(
      call: _deliverablesRepo.getDeliverables,
      onSuccess: (data) {
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
      onError: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }
}
