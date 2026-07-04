import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit({required BaseAuthRepo authRepo})
      : _authRepo = authRepo,
        super(const ProfileCubitState.initial());

  final BaseAuthRepo _authRepo;

  Future<void> fetchProfile() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _authRepo.getUserProfile();
    result.when(
      success: (profile) => emit(
        state.copyWith(cubitStatus: CubitStatus.success, profile: profile),
      ),
      failure: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }

  /// Replace the cached profile after a successful edit (no network round-trip).
  void setProfile(UserProfileModel profile) {
    emit(state.copyWith(cubitStatus: CubitStatus.success, profile: profile));
  }
}
