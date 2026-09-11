import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseBillingRepo {
  Future<Result<List<PaymentModel>>> getPayments();
  Future<Result<PaymentModel>> getPaymentDetails(String paymentId);
  Future<Result<PaymentQuoteModel>> getPaymentQuote(String projectId);
  Future<Result<void>> submitPayment({
    required String projectId,
    required String receiptPath,
  });
}
