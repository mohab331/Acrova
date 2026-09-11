import 'package:acrova/utils/helpers/result.dart';

abstract class BaseContactUsRepo {
  Future<Result<void>> submitInquiry({
    required String email,
    required String mobileNumber,
    required String details,
  });
}
