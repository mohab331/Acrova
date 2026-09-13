import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/cubit/revision_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // final targetId = id ?? state.revisionId ?? state.revision?.id;
    // if (targetId == null || targetId.isEmpty) return;
    //
    // emit(
    //   state.copyWith(cubitStatus: CubitStatus.loading, revisionId: targetId),
    // );
    // final result = await _revisionsRepo.getRevision(targetId);
    // result.when(
    //   success: (revision) => emit(
    //     state.copyWith(cubitStatus: CubitStatus.success, revision: revision),
    //   ),
    //   failure: (error) => emit(
    //     state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
    //   ),
    // );
  }

  Future<void> refresh() async {
    await fetchRevision();
  }
}
