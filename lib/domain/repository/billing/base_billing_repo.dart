import 'package:acrova/data/models/request/billing/get_payment_details_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/data/models/response/billing/payment_quote_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseBillingRepo {
  Future<Result<List<PaymentResponseModel>>> getPayments();
  Future<Result<PaymentResponseModel>> getPaymentDetails(
    GetPaymentDetailsRequestModel request,
  );
  Future<Result<PaymentQuoteResponseModel>> getPaymentQuote(
    GetPaymentQuoteRequestModel request,
  );
  Future<Result<void>> submitPayment(SubmitPaymentRequestModel request);
}
