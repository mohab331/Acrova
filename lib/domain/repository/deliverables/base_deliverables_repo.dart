import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/deliverables/cubit/deliverables_state.dart';
import 'package:acrova/utils/helpers/result.dart';

class DeliverablesData {
  const DeliverablesData({
    required this.blueprints,
    required this.renders,
    required this.walkthroughs,
    this.projectName,
    this.projectThumbnailUrl,
    this.allFilesZipUrl,
  });

  final List<BlueprintModel> blueprints;
  final List<RenderModel> renders;
  final List<WalkthroughModel> walkthroughs;
  final String? projectName;
  final String? projectThumbnailUrl;
  final String? allFilesZipUrl;
}

abstract class BaseDeliverablesRepo {
  Future<Result<DeliverablesData>> getDeliverables();
}
