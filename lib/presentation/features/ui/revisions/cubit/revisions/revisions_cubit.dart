import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:bloc/bloc.dart';

import 'revisions_state.dart';

class RevisionsCubit extends Cubit<RevisionsCubitState> {
  RevisionsCubit({required BaseRevisionsRepo revisionsRepo})
    : _revisionsRepo = revisionsRepo,
      super(const RevisionsCubitState.initial());

  final BaseRevisionsRepo _revisionsRepo;

  Future<void> fetchRevisions() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    await safeCubitCall<List<RevisionModel>>(
      call: _revisionsRepo.getRevisions,
      onSuccess: (revisions) => emit(
        state.copyWith(cubitStatus: CubitStatus.success, revisions: revisions),
      ),
      onError: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }
}
