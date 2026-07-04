import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'revisions_state.dart';

class RevisionsCubit extends Cubit<RevisionsCubitState> {
  RevisionsCubit({required BaseRevisionsRepo revisionsRepo})
      : _revisionsRepo = revisionsRepo,
        super(const RevisionsCubitState.initial());

  final BaseRevisionsRepo _revisionsRepo;

  Future<void> fetchRevisions() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _revisionsRepo.getRevisions();
    result.when(
      success: (revisions) => emit(state.copyWith(
        cubitStatus: CubitStatus.success,
        revisions: revisions,
      )),
      failure: (error) => emit(state.copyWith(
        cubitStatus: CubitStatus.error,
        appErrorModel: error,
      )),
    );
  }
}
