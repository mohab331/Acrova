import 'package:acrova/data/models/response/deliverables/deliverables_response_model.dart';
import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/utils/helpers/result.dart';

class DeliverablesRepoImpl implements BaseDeliverablesRepo {
  DeliverablesRepoImpl();

  @override
  Future<Result<DeliverablesResponseModel>> getDeliverables() async {
    return const Success(
      DeliverablesResponseModel(blueprints: [], renders: [], walkthroughs: []),
    );
  }
}
