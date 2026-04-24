import '../base_request_model.dart';

class SignInRequestModel implements BaseRequestModel {
  final String? phone;
  final String? password;
  final String? firebaseTokenKey;

  SignInRequestModel({this.phone, this.password, this.firebaseTokenKey});

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
}
