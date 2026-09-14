import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/request/auth/send_otp_request_model.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/user_status.dart';
import 'package:acrova/utils/extensions/non_null_extension.dart';
import 'package:bloc/bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({
    required BaseAuthRepo baseAuthRepo,
    required BaseFCMTokenRepo baseFCMTokenRepo,
  }) : _baseAuthRepo = baseAuthRepo,
       _fcmTokenRepo = baseFCMTokenRepo,
       super(const AuthCubitState.initial());

  final BaseAuthRepo _baseAuthRepo;
  // ignore: unused_field
  final BaseFCMTokenRepo _fcmTokenRepo;
  Future<void> sendOTP(String phoneNumber) async {
    emit(state.copyWith(sendOTPCubitStatus: CubitStatus.loading));
    final result = await _baseAuthRepo.login(
      SendOTPRequestModel(phone: phoneNumber),
    );
    result.when(
      success: (_) => emit(
        state.copyWith(
          sendOTPCubitStatus: CubitStatus.success,
          phoneNumber: phoneNumber,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          sendOTPCubitStatus: CubitStatus.error,
          sendOTPAppErrorModel: error,
        ),
      ),
    );
  }

  void setUserStatus(UserStatus userStatus) {
    emit(
      state.copyWith(
        userStatus: userStatus,
        clearUserModel: userStatus != UserStatus.authenticated,
      ),
    );
  }

  /// Prevents later profile refreshes from retriggering OTP completion routing.
  void markPostLoginRoutingHandled() {
    emit(state.copyWith(verifyOTPCubitStatus: CubitStatus.initial));
  }

  Future<void> resendOTP() async {
    emit(state.copyWith(resendOTPCubitStatus: CubitStatus.loading));
    final result = await _baseAuthRepo.login(
      SendOTPRequestModel(phone: state.phoneNumber ?? ''),
    );
    result.when(
      success: (_) =>
          emit(state.copyWith(resendOTPCubitStatus: CubitStatus.success)),
      failure: (error) => emit(
        state.copyWith(
          resendOTPCubitStatus: CubitStatus.error,
          resendOTPAppErrorModel: error,
        ),
      ),
    );
  }

  Future<void> getUser() async {
    emit(state.copyWith(getUserCubitStatus: CubitStatus.loading));
    final response = await _baseAuthRepo.getUserProfile();
    response.when(
      success: (data) {
        emit(
          state.copyWith(
            getUserCubitStatus: CubitStatus.success,
            userModel: data,
            clearUserModel: data == null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            getUserCubitStatus: CubitStatus.error,
            getUserErrorModel: error,
          ),
        );
      },
    );
  }

  Future<void> verifyOtp(String? otp) async {
    if (otp.isNullOrEmpty) {
      emit(
        state.copyWith(
          verifyOTPCubitStatus: CubitStatus.error,
          verifyOtpAppErrorModel: AppErrorModel.fromException(
            ArgumentError('OTP is required', 'OTP'),
          ),
        ),
      );
      return;
    }
    emit(state.copyWith(verifyOTPCubitStatus: CubitStatus.loading));
    final otpResult = await _baseAuthRepo.verifyOtp(
      VerifyOTPRequestModel(otp: otp),
    );
    otpResult.when(
      success: (verifyOTPResponseModel) async {
        emit(
          state.copyWith(
            verifyOTPCubitStatus: CubitStatus.success,
            userStatus: UserStatus.authenticated,
          ),
        );
      },
      failure: (error) => emit(
        state.copyWith(
          verifyOTPCubitStatus: CubitStatus.error,
          verifyOtpAppErrorModel: error,
        ),
      ),
    );
  }

  void resetToInitial() => emit(const AuthCubitState.initial());

  Future<void> clearAuthData() => _baseAuthRepo.clearUserData();
}
