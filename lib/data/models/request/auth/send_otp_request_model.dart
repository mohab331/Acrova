import '../base_request_model.dart';

class SendOTPRequestModel extends BaseRequestModel {
  const SendOTPRequestModel({
    required this.phone,
  });

  final String phone;

  @override
  Map<String, dynamic> toJson() => {
    'phone_number': phone,
  };

  @override
  List<Object?> get props => [phone];

  @override
  String toString() {
    return 'SendOTPRequestModel(phone: $phone)';
  }
}
