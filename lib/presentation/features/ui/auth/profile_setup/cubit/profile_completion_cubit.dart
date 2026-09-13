import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:bloc/bloc.dart';

import 'profile_completion_state.dart';

class ProfileCompletionCubit extends Cubit<ProfileCompletionState> {
  ProfileCompletionCubit({
    required BaseAuthRepo authRepo,
    required BaseImagePickerService imagePicker,
    String? initialPhone,
    String? initialLanguage,
  }) : _authRepo = authRepo,
       _imagePicker = imagePicker,
       super(
         ProfileCompletionState.initial(
           mobileNumber: initialPhone ?? '',
           language: initialLanguage ?? 'en',
         ),
       );

  final BaseAuthRepo _authRepo;
  final BaseImagePickerService _imagePicker;

  void updateName(String value) => emit(state.copyWith(name: value));

  void updateEmail(String value) => emit(state.copyWith(email: value));

  void updateMobile(String value) => emit(state.copyWith(mobileNumber: value));

  void updateNationalId(String value) =>
      emit(state.copyWith(nationalId: value));

  void updateLanguage(String value) => emit(state.copyWith(language: value));

  Future<void> pickAvatarFromGallery() async {
    try {
      final file = await _imagePicker.pickFromGallery();
      if (file != null) {
        emit(state.copyWith(avatarPath: file.path));
      }
    } catch (e, s) {
      AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    }
  }

  Future<void> pickAvatarFromCamera() async {
    try {
      final file = await _imagePicker.pickFromCamera();
      if (file != null) {
        emit(state.copyWith(avatarPath: file.path));
      }
    } catch (e, s) {
      AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    }
  }

  void removeAvatar() => emit(state.copyWith(clearAvatar: true));

  Future<void> submit() async {
    if (!state.validate()) return;

    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final result = await _authRepo.saveProfile(
      SaveProfileRequestModel(
        name: state.name.trim(),
        email: state.email.trim(),
        nationalId: state.nationalId.trim(),
        language: state.language,
        mobileNumber: state.mobileNumber.trim(),
        avatarPath: state.avatarPath,
      ),
    );

    result.when(
      success: (_) => emit(state.copyWith(cubitStatus: CubitStatus.success)),
      failure: (error) => emit(
        state.copyWith(
          cubitStatus: CubitStatus.error,
          appErrorModel: error,
        ),
      ),
    );
  }
}
