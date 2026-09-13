import '../base_request_model.dart';

class SubmitInquiryRequestModel extends BaseRequestModel {
  const SubmitInquiryRequestModel({
    required this.email,
    required this.mobileNumber,
    required this.details,
  });

  final String email;
  final String mobileNumber;
  final String details;

  @override
  Map<String, dynamic> toJson() => {
    'email': email,
    'mobile_number': mobileNumber,
    'details': details,
  };

  @override
  List<Object?> get props => [email, mobileNumber, details];

  @override
  String toString() {
    return 'SubmitInquiryRequestModel('
        'email: $email, '
        'mobileNumber: $mobileNumber, '
        'details: $details'
        ')';
  }
}
