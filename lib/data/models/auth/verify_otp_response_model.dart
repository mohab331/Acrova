import 'package:equatable/equatable.dart';

class VerifyOTPResponseModel extends Equatable {
  const VerifyOTPResponseModel({
    required this.refreshToken,
    required this.accessToken,
  });
  final String? accessToken;
  final String? refreshToken;
  VerifyOTPResponseModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) => VerifyOTPResponseModel(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );

  factory VerifyOTPResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyOTPResponseModel(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
      );

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
