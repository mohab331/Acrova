import '../base_request_model.dart';

class GetPaymentDetailsRequestModel extends BaseRequestModel {
  const GetPaymentDetailsRequestModel({
    required this.paymentId,
  });

  final String paymentId;

  @override
  Map<String, dynamic> toJson() => {
    'payment_id': paymentId,
  };

  @override
  List<Object?> get props => [paymentId];

  @override
  String toString() {
    return 'GetPaymentDetailsRequestModel(paymentId: $paymentId)';
  }
}
