import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/request/revision/create_revision_request.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/data/models/revision/revision_quota_model.dart';

class RemoteRevisionsDataSource implements BaseRevisionsDataSource {
  RemoteRevisionsDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<RevisionModel>> getRevisions() async {
    throw UnimplementedError('Remote getRevisions not implemented yet');
  }

  @override
  Future<RevisionModel> getRevision(String id) async {
    throw UnimplementedError('Remote getRevision not implemented yet');
  }

  @override
  Future<RevisionQuotaModel> getQuota() async {
    throw UnimplementedError('Remote getQuota not implemented yet');
  }

  @override
  Future<RevisionModel> createRevision(CreateRevisionRequest request) async {
    throw UnimplementedError('Remote createRevision not implemented yet');
  }
}
