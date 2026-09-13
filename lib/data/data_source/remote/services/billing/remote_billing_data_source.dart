import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/request/billing/get_payment_details_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/data/models/response/billing/payment_quote_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_response_model.dart';

class RemoteBillingDataSource implements BaseBillingDataSource {
  const RemoteBillingDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;
  ApiClient get apiClient => _apiClient;

  @override
  Future<List<PaymentResponseModel>> getPayments() async {
    throw UnimplementedError(
      'RemoteBillingDataSource.getPayments not implemented yet.',
    );
  }

  @override
  Future<PaymentResponseModel> getPaymentDetails(
    GetPaymentDetailsRequestModel request,
  ) async {
    throw UnimplementedError(
      'RemoteBillingDataSource.getPaymentDetails not implemented yet.',
    );
  }

  @override
  Future<void> submitPayment(SubmitPaymentRequestModel request) async {
    throw UnimplementedError(
      'RemoteBillingDataSource.submitPayment not implemented yet.',
    );
  }

  @override
  Future<PaymentQuoteResponseModel> getPaymentQuote(
    GetPaymentQuoteRequestModel request,
  ) async {
    throw UnimplementedError(
      'RemoteBillingDataSource.getPaymentQuote not implemented yet.',
    );
  }
}
