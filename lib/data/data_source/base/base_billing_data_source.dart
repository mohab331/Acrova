import 'package:acrova/data/models/request/billing/get_payment_details_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/data/models/response/billing/payment_quote_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_response_model.dart';

abstract class BaseBillingDataSource {
  Future<List<PaymentResponseModel>> getPayments();
  Future<PaymentResponseModel> getPaymentDetails(GetPaymentDetailsRequestModel request);
  Future<void> submitPayment(SubmitPaymentRequestModel request);
  Future<PaymentQuoteResponseModel> getPaymentQuote(GetPaymentQuoteRequestModel request);
}
