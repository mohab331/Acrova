import 'package:acrova/data/models/response/deliverables/deliverables_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

@Deprecated('Use DeliverablesResponseModel instead')
typedef DeliverablesData = DeliverablesResponseModel;

abstract class BaseDeliverablesRepo {
  Future<Result<DeliverablesResponseModel>> getDeliverables();
}
