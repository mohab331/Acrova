import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'revision_detail_state.dart';

class RevisionDetailCubit extends Cubit<RevisionDetailState> {
  RevisionDetailCubit({
    required BaseRevisionsRepo revisionsRepo,
    RevisionModel? initialRevision,
  })  : _revisionsRepo = revisionsRepo,
        super(RevisionDetailState.initial(revision: initialRevision));

  final BaseRevisionsRepo _revisionsRepo;

  Future<void> fetchRevision(String id) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _revisionsRepo.getRevision(id);
    result.when(
      success: (revision) => emit(
        state.copyWith(cubitStatus: CubitStatus.success, revision: revision),
      ),
      failure: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }

  Future<void> refresh() async {
    final id = state.revision?.id;
    if (id != null) await fetchRevision(id);
  }
}
