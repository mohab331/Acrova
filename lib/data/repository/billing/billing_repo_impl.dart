import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/models/request/billing/get_payment_details_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/data/models/response/billing/payment_quote_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_response_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class BillingRepoImpl implements BaseBillingRepo {
  final BaseBillingDataSource _dataSource;

  BillingRepoImpl({required BaseBillingDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Result<List<PaymentResponseModel>>> getPayments() =>
      safeAsyncCall(_dataSource.getPayments);

  @override
  Future<Result<PaymentResponseModel>> getPaymentDetails(
    GetPaymentDetailsRequestModel request,
  ) => safeAsyncCall(() => _dataSource.getPaymentDetails(request));

  @override
  Future<Result<PaymentQuoteResponseModel>> getPaymentQuote(
    GetPaymentQuoteRequestModel request,
  ) => safeAsyncCall(() => _dataSource.getPaymentQuote(request));

  @override
  Future<Result<void>> submitPayment(SubmitPaymentRequestModel request) =>
      safeAsyncCall(() => _dataSource.submitPayment(request));
}
