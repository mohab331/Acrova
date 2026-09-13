import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/request/profile/update_profile_request_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:bloc/bloc.dart';

import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required BaseAuthRepo authRepo,
    required BaseImagePickerService imagePicker,
    required UserProfileResponseModel initialProfile,
  }) : _authRepo = authRepo,
       _imagePicker = imagePicker,
       super(EditProfileState.fromProfile(initialProfile));

  final BaseAuthRepo _authRepo;
  final BaseImagePickerService _imagePicker;

  void updateName(String value) => emit(state.copyWith(name: value));

  void updateEmail(String value) => emit(state.copyWith(email: value));

  void updateMobile(String value) => emit(state.copyWith(mobileNumber: value));

  /// Pick a new avatar from the gallery.
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

  /// Pick a new avatar from the camera.
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

  void removeAvatar() => emit(state.copyWith(avatarPath: ''));

  bool validate() {
    final name = state.name.trim();
    final email = state.email.trim();
    final mobile = state.mobileNumber.trim();

    final bool isNameValid = AppValidators.name(name) == null;
    final bool isEmailValid = AppValidators.isValidEmail(email);
    final bool isMobileValid = AppValidators.isValidSaudiPhone(mobile);
    return isNameValid && isEmailValid && isMobileValid;
  }

  Future<void> submit() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final result = await _authRepo.updateUserProfile(
      UpdateProfileRequestModel(
        name: state.name.trim(),
        email: state.email.trim(),
        mobileNumber: state.mobileNumber.trim(),
        avatarPath: state.avatarPath,
      ),
    );
    result.when(
      success: (profile) =>
          emit(state.copyWith(cubitStatus: CubitStatus.success)),
      failure: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }
}
