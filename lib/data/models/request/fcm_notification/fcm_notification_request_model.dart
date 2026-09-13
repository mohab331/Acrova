import '../base_request_model.dart';

class FCMRequestModel extends BaseRequestModel {
  const FCMRequestModel({required this.fcmToken});

  final String fcmToken;

  @override
  List<Object?> get props => [fcmToken];

  @override
  Map<String, dynamic> toJson() {
    return {'firebaseTokenKey': fcmToken};
  }

  @override
  String toString() {
    return 'FCMRequestModel(fcmToken: $fcmToken)';
  }
}
