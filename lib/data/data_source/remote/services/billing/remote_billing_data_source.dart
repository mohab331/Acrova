import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/billing/payment_model.dart';

class RemoteBillingDataSource implements BaseBillingDataSource {
  const RemoteBillingDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<PaymentModel>> getPayments() async {
    // TODO: implement real API call when backend endpoint is available
    // Example:
    // final response = await _apiClient.get('/billing/payments');
    // return (response.data as List)
    //     .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
    //     .toList();
    throw UnimplementedError('RemoteBillingDataSource.getPayments not implemented yet.');
  }

  @override
  Future<PaymentModel> getPaymentDetails(String paymentId) async {
    // TODO: implement real API call when backend endpoint is available
    // Example:
    // final response = await _apiClient.get('/billing/payments/$paymentId');
    // return PaymentModel.fromJson(response.data as Map<String, dynamic>);
    throw UnimplementedError('RemoteBillingDataSource.getPaymentDetails not implemented yet.');
  }
}
