import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:bloc/bloc.dart';

import 'edit_profile_state.dart';

/// Validation error codes — resolved to localized strings in the UI layer.
enum EditProfileFieldError { nameRequired, emailRequired, emailInvalid, mobileInvalid }

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required BaseAuthRepo authRepo,
    required BaseImagePickerService imagePicker,
    required UserProfileModel initialProfile,
  })  : _authRepo = authRepo,
        _imagePicker = imagePicker,
        super(EditProfileState.fromProfile(initialProfile));

  final BaseAuthRepo _authRepo;
  final BaseImagePickerService _imagePicker;

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  void updateName(String value) => emit(
        state.copyWith(name: value, nameError: () => null, showErrorBanner: false),
      );

  void updateEmail(String value) => emit(
        state.copyWith(email: value, emailError: () => null, showErrorBanner: false),
      );

  void updateMobile(String value) => emit(
        state.copyWith(mobileNumber: value, mobileError: () => null, showErrorBanner: false),
      );

  void dismissBanner() => emit(state.copyWith(showErrorBanner: false));

  /// Pick a new avatar from the gallery.
  Future<void> pickAvatarFromGallery() async {
    try {
      final file = await _imagePicker.pickFromGallery();
      if (file != null) {
        emit(state.copyWith(avatarPath: file.path, avatarRemoved: false));
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
        emit(state.copyWith(avatarPath: file.path, avatarRemoved: false));
      }
    } catch (e, s) {
      AppLogger.instance.logError(e.toString(), error: e, stackTrace: s);
    }
  }

  /// Remove the current avatar (shows placeholder).
  void removeAvatar() => emit(state.copyWith(avatarRemoved: true));

  /// Returns the field-error code for each invalid field (null = valid).
  ({
    EditProfileFieldError? name,
    EditProfileFieldError? email,
    EditProfileFieldError? mobile,
  }) _validate() {
    final name = state.name.trim();
    final email = state.email.trim();
    final mobile = state.mobileNumber.trim();
    final mobileDigits = mobile.replaceAll(RegExp(r'\D'), '');

    return (
      name: name.isEmpty ? EditProfileFieldError.nameRequired : null,
      email: email.isEmpty
          ? EditProfileFieldError.emailRequired
          : (!_emailRegex.hasMatch(email)
              ? EditProfileFieldError.emailInvalid
              : null),
      mobile: mobileDigits.length < 9 ? EditProfileFieldError.mobileInvalid : null,
    );
  }

  /// Validates and resolves error codes via [resolve]; submits if valid.
  Future<void> submit({
    required String Function(EditProfileFieldError) resolve,
  }) async {
    final errors = _validate();
    final hasError =
        errors.name != null || errors.email != null || errors.mobile != null;

    if (hasError) {
      emit(state.copyWith(
        nameError: () => errors.name != null ? resolve(errors.name!) : null,
        emailError: () => errors.email != null ? resolve(errors.email!) : null,
        mobileError: () => errors.mobile != null ? resolve(errors.mobile!) : null,
        showErrorBanner: true,
      ));
      return;
    }

    emit(state.copyWith(cubitStatus: CubitStatus.loading, showErrorBanner: false));

    final result = await _authRepo.updateUserProfile(
      UpdateProfileRequest(
        name: state.name.trim(),
        email: state.email.trim(),
        mobileNumber: state.mobileNumber.trim(),
        avatarPath: state.avatarPath,
      ),
    );

    result.when(
      success: (profile) => emit(state.copyWith(
        cubitStatus: CubitStatus.success,
        updatedProfile: profile,
      )),
      failure: (error) => emit(state.copyWith(
        cubitStatus: CubitStatus.error,
        appErrorModel: error,
      )),
    );
  }
}
