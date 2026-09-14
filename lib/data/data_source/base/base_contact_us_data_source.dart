import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';

abstract class BaseContactUsDataSource {
  Future<void> submitInquiry(SubmitInquiryRequestModel request);
}
