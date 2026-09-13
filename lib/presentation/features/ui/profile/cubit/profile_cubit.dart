import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit({required BaseAuthRepo authRepo})
    : _authRepo = authRepo,
      super(const ProfileCubitState.initial());

  final BaseAuthRepo _authRepo;

  Future<void> updateProfile(UserProfileModel profile) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _authRepo.updateUserProfile(
      UpdateProfileRequest(
        name: profile.name ?? '',
        email: profile.email ?? '',
        mobileNumber: profile.mobileNumber ?? '',
      ),
    );
    result.when(
      success: (data) {
        emit(state.copyWith(cubitStatus: CubitStatus.success, profile: data));
      },
      failure: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }
}
