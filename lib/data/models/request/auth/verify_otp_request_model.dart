import '../base_request_model.dart';

class VerifyOTPRequestModel extends BaseRequestModel {
  const VerifyOTPRequestModel({required this.otp});

  final String? otp;

  VerifyOTPRequestModel copyWith({String? otp}) =>
      VerifyOTPRequestModel(otp: otp ?? this.otp);

  @override
  Map<String, dynamic> toJson() => {'otp': otp};

  @override
  List<Object?> get props => [otp];

  @override
  String toString() {
    return 'VerifyOTPRequestModel(otp: $otp)';
  }
}
