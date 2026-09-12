import 'package:equatable/equatable.dart';

class VerifyOTPRequestModel extends Equatable {
  const VerifyOTPRequestModel({required this.otp});
  final String? otp;

  VerifyOTPRequestModel copyWith({String? otp}) =>
      VerifyOTPRequestModel(otp: otp ?? this.otp);

  Map<String, dynamic> toJson() {
    return {'otp': otp};
  }

  @override
  List<Object?> get props => [otp];
}
