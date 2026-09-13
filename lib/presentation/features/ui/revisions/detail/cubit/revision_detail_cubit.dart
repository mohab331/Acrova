import 'package:acrova/data/models/request/revision/get_revision_request_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/cubit/revision_detail_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevisionDetailCubit extends Cubit<RevisionDetailState> {
  RevisionDetailCubit({
    required BaseRevisionsRepo revisionsRepo,
    RevisionResponseModel? initialRevision,
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
    final result = await _revisionsRepo.getRevision(
      GetRevisionRequestModel(id: targetId),
    );
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
    await fetchRevision();
  }
}
