import 'package:acrova/data/models/billing/payment_model.dart';

abstract class BaseBillingDataSource {
  Future<List<PaymentModel>> getPayments();
  Future<PaymentModel> getPaymentDetails(String paymentId);
}
