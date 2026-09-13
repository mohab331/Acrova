import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/request/revision/create_revision_request_model.dart';
import 'package:acrova/data/models/request/revision/get_revision_request_model.dart';
import 'package:acrova/data/models/response/revision/revision_quota_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';

class RemoteRevisionsDataSource implements BaseRevisionsDataSource {
  RemoteRevisionsDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<RevisionResponseModel>> getRevisions() async {
    throw UnimplementedError('Remote getRevisions not implemented yet');
  }

  @override
  Future<RevisionResponseModel> getRevision(
    GetRevisionRequestModel request,
  ) async {
    throw UnimplementedError('Remote getRevision not implemented yet');
  }

  @override
  Future<RevisionQuotaResponseModel> getQuota() async {
    throw UnimplementedError('Remote getQuota not implemented yet');
  }

  @override
  Future<RevisionResponseModel> createRevision(
    CreateRevisionRequestModel request,
  ) async {
    throw UnimplementedError('Remote createRevision not implemented yet');
  }

  @override
  Future<List<String>> getDeliverableRefs() async {
    throw UnimplementedError('Remote getDeliverableRefs not implemented yet');
  }
}
