import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/models/request/revision/create_revision_request_model.dart';
import 'package:acrova/data/models/request/revision/get_revision_request_model.dart';
import 'package:acrova/data/models/response/revision/revision_quota_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class RevisionsRepoImpl implements BaseRevisionsRepo {
  const RevisionsRepoImpl({required BaseRevisionsDataSource dataSource})
    : _dataSource = dataSource;

  final BaseRevisionsDataSource _dataSource;

  @override
  Future<Result<List<RevisionResponseModel>>> getRevisions() =>
      safeAsyncCall(_dataSource.getRevisions);

  @override
  Future<Result<RevisionResponseModel>> getRevision(
    GetRevisionRequestModel request,
  ) => safeAsyncCall(() => _dataSource.getRevision(request));

  @override
  Future<Result<RevisionQuotaResponseModel>> getQuota() =>
      safeAsyncCall(_dataSource.getQuota);

  @override
  Future<Result<RevisionResponseModel>> createRevision(
    CreateRevisionRequestModel request,
  ) => safeAsyncCall(() => _dataSource.createRevision(request));

  @override
  Future<Result<List<String>>> getDeliverableRefs() =>
      safeAsyncCall(_dataSource.getDeliverableRefs);
}
