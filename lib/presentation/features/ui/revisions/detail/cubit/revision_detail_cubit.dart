import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:bloc/bloc.dart';

import 'revision_detail_state.dart';

class RevisionDetailCubit extends Cubit<RevisionDetailState> {
  RevisionDetailCubit({
    required BaseRevisionsRepo revisionsRepo,
    RevisionModel? initialRevision,
    String? revisionId,
  }) : _revisionsRepo = revisionsRepo,
       super(
         RevisionDetailState.initial(
           revision: initialRevision,
           revisionId: revisionId,
         ),
       );

  final BaseRevisionsRepo _revisionsRepo;

  Future<void> fetchRevision([String? id]) async {
    final targetId = id ?? state.revisionId ?? state.revision?.id;
    if (targetId == null || targetId.isEmpty) return;

    emit(
      state.copyWith(cubitStatus: CubitStatus.loading, revisionId: targetId),
    );
    await safeCubitCall<RevisionModel>(
      call: () => _revisionsRepo.getRevision(targetId),
      onSuccess: (revision) => emit(
        state.copyWith(cubitStatus: CubitStatus.success, revision: revision),
      ),
      onError: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }

  Future<void> refresh() async {
    await fetchRevision();
  }
}
