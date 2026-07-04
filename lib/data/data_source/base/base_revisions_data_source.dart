import 'package:acrova/data/models/request/revision/create_revision_request.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/data/models/revision/revision_quota_model.dart';

abstract class BaseRevisionsDataSource {
  Future<List<RevisionModel>> getRevisions();
  Future<RevisionModel> getRevision(String id);
  Future<RevisionQuotaModel> getQuota();
  Future<RevisionModel> createRevision(CreateRevisionRequest request);
}
