import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/request/revision/create_revision_request.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/revision_category_enum.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:bloc/bloc.dart';

import 'revision_request_state.dart';

enum RevisionRequestFieldError { categoryRequired, detailsRequired }

class RevisionRequestCubit extends Cubit<RevisionRequestState> {
  RevisionRequestCubit({
    required BaseRevisionsRepo revisionsRepo,
    required BaseImagePickerService imagePicker,
  })  : _revisionsRepo = revisionsRepo,
        _imagePicker = imagePicker,
        super(const RevisionRequestState.initial());

  final BaseRevisionsRepo _revisionsRepo;
  final BaseImagePickerService _imagePicker;

  Future<void> fetchQuota() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _revisionsRepo.getQuota();
    result.when(
      success: (quota) =>
          emit(state.copyWith(cubitStatus: CubitStatus.success, quota: quota)),
      failure: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }

  void selectCategory(RevisionCategory category) => emit(state.copyWith(
        selectedCategory: () => category,
        categoryError: () => null,
      ));

  void selectDeliverable(String? ref) =>
      emit(state.copyWith(deliverableRef: () => ref));

  void updateDetails(String value) =>
      emit(state.copyWith(details: value, detailsError: () => null));

  Future<void> addAttachment() async {
    try {
      final file = await _imagePicker.pickFromGallery();
      if (file != null) {
        emit(state.copyWith(
          attachmentPaths: [...state.attachmentPaths, file.path],
        ));
      }
    } catch (e, s) {
      AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    }
  }

  void removeAttachment(String path) => emit(state.copyWith(
        attachmentPaths:
            state.attachmentPaths.where((p) => p != path).toList(),
      ));

  Future<void> submit({
    required String Function(RevisionRequestFieldError) resolve,
  }) async {
    final detailsMissing = state.details.trim().isEmpty;

    if ( detailsMissing) {
      emit(state.copyWith(
        detailsError: () => detailsMissing
            ? resolve(RevisionRequestFieldError.detailsRequired)
            : null,
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    final result = await _revisionsRepo.createRevision(
      CreateRevisionRequest(
        details: state.details.trim(),
        deliverableRef: state.deliverableRef,
        attachmentPaths: state.attachmentPaths,
        isPaid: !(state.quota?.hasFreeRemaining ?? true),
      ),
    );

    result.when(
      success: (revision) => emit(state.copyWith(
        isSubmitting: false,
        createdRevision: revision,
      )),
      failure: (error) => emit(state.copyWith(
        isSubmitting: false,
        appErrorModel: error,
      )),
    );
  }
}
