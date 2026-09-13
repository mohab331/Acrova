import 'package:acrova/data/models/request/revision/create_revision_request_model.dart';
import 'package:acrova/data/models/request/revision/get_revision_request_model.dart';
import 'package:acrova/data/models/response/revision/revision_quota_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseRevisionsRepo {
  Future<Result<List<RevisionResponseModel>>> getRevisions();
  Future<Result<RevisionResponseModel>> getRevision(GetRevisionRequestModel request);
  Future<Result<RevisionQuotaResponseModel>> getQuota();
  Future<Result<RevisionResponseModel>> createRevision(CreateRevisionRequestModel request);
  Future<Result<List<String>>> getDeliverableRefs();
}
