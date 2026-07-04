import 'package:acrova/data/models/request/revision/create_revision_request.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/data/models/revision/revision_quota_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseRevisionsRepo {
  Future<Result<List<RevisionModel>>> getRevisions();
  Future<Result<RevisionModel>> getRevision(String id);
  Future<Result<RevisionQuotaModel>> getQuota();
  Future<Result<RevisionModel>> createRevision(CreateRevisionRequest request);
}
