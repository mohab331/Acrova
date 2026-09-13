import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class ContactUsRepoImpl implements BaseContactUsRepo {
  const ContactUsRepoImpl();

  @override
  Future<Result<void>> submitInquiry(SubmitInquiryRequestModel request) =>
      safeAsyncCall(() async {});
}
