import 'package:equatable/equatable.dart';

class OTPState extends Equatable {
  const OTPState({
    this.otp,
    this.isTimerFinished = false,
    this.resendOTPCount = 0,
  });
  final String? otp;
  final int resendOTPCount;

  final bool isTimerFinished;
  bool get shouldBlockResend => resendOTPCount >= 2;
  bool get showResendOTPButton => isTimerFinished;
  OTPState copyWith({String? otp, int? resendOTPCount, bool? isTimerFinished}) {
    return OTPState(
      otp: otp ?? this.otp,
      isTimerFinished: isTimerFinished ?? this.isTimerFinished,
      resendOTPCount: resendOTPCount ?? this.resendOTPCount,
    );
  }

  @override
  List<Object?> get props => [otp, isTimerFinished, resendOTPCount];
}
