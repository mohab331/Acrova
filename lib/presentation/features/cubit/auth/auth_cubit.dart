import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({
    required BaseAuthRepo baseAuthRepo,
    required BaseFCMTokenRepo baseFCMTokenRepo,
  })  : _baseAuthRepo = baseAuthRepo,
        _fcmTokenRepo = baseFCMTokenRepo,
        super(const AuthCubitState.initial());

  final BaseAuthRepo _baseAuthRepo;
  // ignore: unused_field
  final BaseFCMTokenRepo _fcmTokenRepo;

  // ── Auth ──────────────────────────────────────────────────────────────────

  /// Step 1: Send OTP to [phoneNumber].
  Future<void> login(String phoneNumber) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _baseAuthRepo.login(phoneNumber);
    result.when(
      success: (_) => emit(state.copyWith(cubitStatus: CubitStatus.success)),
      failure: (error) => emit(state.copyWith(
        cubitStatus: CubitStatus.error,
        appErrorModel: error,
      )),
    );
  }

  /// Step 2: Verify OTP then immediately check new-user flag.
  ///
  /// On success, [AuthCubitState.isNewUser] will be set:
  /// - `true`  → navigate to ProfileSetupPage
  /// - `false` → navigate to HomePage
  Future<void> verifyOtpAndCheckNewUser(String otp) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final otpResult = await _baseAuthRepo.verifyOtp(otp);
     otpResult.when(
      success: (_) async {
        final newUserResult = await _baseAuthRepo.isNewUser();
        newUserResult.when(
          success: (isNew) => emit(state.copyWith(
            cubitStatus: CubitStatus.success,
            isNewUser: isNew,
          )),
          failure: (_) => emit(state.copyWith(
            cubitStatus: CubitStatus.success,
            isNewUser: false, // default to home on check failure
          )),
        );
      },
      failure: (error) => emit(state.copyWith(
        cubitStatus: CubitStatus.error,
        appErrorModel: error,
      )),
    );
  }

  /// Step 3 (new users only): Save KYC profile then emit success.
  /// Collects: full name, email, mobile number, national ID, preferred language.
  Future<void> saveProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  }) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _baseAuthRepo.saveProfile(
      name: name,
      email: email,
      nationalId: nationalId,
      language: language,
    );
    result.when(
      success: (_) => emit(state.copyWith(
        cubitStatus: CubitStatus.success,
        isNewUser: false,
      )),
      failure: (error) => emit(state.copyWith(
        cubitStatus: CubitStatus.error,
        appErrorModel: error,
      )),
    );
  }

  void resetToInitial() => emit(const AuthCubitState.initial());

  Future<void> clearAuthData() => _baseAuthRepo.clearUserData();
}
