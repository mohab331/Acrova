import 'package:acrova/data/data_source/base/base_contact_us_data_source.dart';
import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class ContactUsRepoImpl implements BaseContactUsRepo {
  const ContactUsRepoImpl({required BaseContactUsDataSource dataSource})
    : _dataSource = dataSource;

  final BaseContactUsDataSource _dataSource;

  @override
  Future<Result<void>> submitInquiry(SubmitInquiryRequestModel request) =>
      safeAsyncCall(() => _dataSource.submitInquiry(request));
}

