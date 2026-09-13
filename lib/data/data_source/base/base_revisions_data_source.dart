import 'package:acrova/data/models/request/revision/create_revision_request_model.dart';
import 'package:acrova/data/models/request/revision/get_revision_request_model.dart';
import 'package:acrova/data/models/response/revision/revision_quota_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';

abstract class BaseRevisionsDataSource {
  Future<List<RevisionResponseModel>> getRevisions();
  Future<RevisionResponseModel> getRevision(GetRevisionRequestModel request);
  Future<RevisionQuotaResponseModel> getQuota();
  Future<RevisionResponseModel> createRevision(CreateRevisionRequestModel request);
  Future<List<String>> getDeliverableRefs();
}
