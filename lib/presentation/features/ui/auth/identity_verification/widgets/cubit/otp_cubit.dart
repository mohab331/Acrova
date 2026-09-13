import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/cubit/otp_state.dart';
import 'package:bloc/bloc.dart';

class OTPCubit extends Cubit<OTPState> {
  OTPCubit() : super(const OTPState());

  void onOTPChanged(String? otp) {
    emit(state.copyWith(otp: otp));
  }

  void setIsTimerFinished(bool isTimerFinished) {
    emit(state.copyWith(isTimerFinished: isTimerFinished));
  }

  void incrementResendOtpCount() {
    emit(state.copyWith(resendOTPCount: (state.resendOTPCount + 1)));
  }

  void decrementResendOtpCount() {
    if (state.resendOTPCount <= 0) return;
    emit(state.copyWith(resendOTPCount: (state.resendOTPCount - 1)));
  }
}
