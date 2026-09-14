import 'package:acrova/data/data_source/base/base_contact_us_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/data_source/remote/network/models/endpoint.dart';
import 'package:acrova/data/data_source/remote/services/contact_us/constants/contact_us_endpoints.dart';
import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';

class RemoteContactUsDataSource implements BaseContactUsDataSource {
  const RemoteContactUsDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<void> submitInquiry(SubmitInquiryRequestModel request) async {
    await _apiClient.post<void>(
      Endpoint(
        path: ContactUsEndpoints.submitInquiry,
        data: request.toJson(),
      ),
      requiresAuth: false,
    );
  }
}
