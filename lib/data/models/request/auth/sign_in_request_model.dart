import 'package:equatable/equatable.dart';

import '../base_request_model.dart';

class SignInRequestModel extends Equatable implements BaseRequestModel {
  final String? phone;
  final String? password;
  final String? firebaseTokenKey;

  const SignInRequestModel({this.phone, this.password, this.firebaseTokenKey});

  SignInRequestModel copyWith({
    String? phone,
    String? password,
    String? firebaseTokenKey,
  }) {
    return SignInRequestModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      firebaseTokenKey: firebaseTokenKey ?? this.firebaseTokenKey,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'firebaseTokenKey': firebaseTokenKey,
    };
  }

  @override
  List<Object?> get props => [phone, password, firebaseTokenKey];
}
