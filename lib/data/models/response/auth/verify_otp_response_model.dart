import 'package:equatable/equatable.dart';

class VerifyOTPResponseModel extends Equatable {
  const VerifyOTPResponseModel({
    this.accessToken,
    this.refreshToken,
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
        accessToken: json['access_token']?.toString(),
        refreshToken: json['refresh_token']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };

  @override
  List<Object?> get props => [accessToken, refreshToken];

  @override
  String toString() {
    return 'VerifyOTPResponseModel('
        'accessToken: $accessToken, '
        'refreshToken: $refreshToken'
        ')';
  }
}
