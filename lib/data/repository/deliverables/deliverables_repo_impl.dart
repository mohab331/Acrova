import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/utils/helpers/result.dart';

class DeliverablesRepoImpl implements BaseDeliverablesRepo {
  DeliverablesRepoImpl();

  @override
  Future<Result<DeliverablesData>> getDeliverables() async {
    return const Success(
      DeliverablesData(
        blueprints: [],
        renders: [],
        walkthroughs: [],
      ),
    );
  }
}
