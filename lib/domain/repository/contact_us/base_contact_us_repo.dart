import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseContactUsRepo {
  Future<Result<void>> submitInquiry(SubmitInquiryRequestModel request);
}
