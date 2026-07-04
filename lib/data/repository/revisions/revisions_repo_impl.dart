import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/models/request/revision/create_revision_request.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/data/models/revision/revision_quota_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class RevisionsRepoImpl implements BaseRevisionsRepo {
  const RevisionsRepoImpl({required BaseRevisionsDataSource dataSource})
      : _dataSource = dataSource;

  final BaseRevisionsDataSource _dataSource;

  @override
  Future<Result<List<RevisionModel>>> getRevisions() =>
      safeAsyncCall(_dataSource.getRevisions);

  @override
  Future<Result<RevisionModel>> getRevision(String id) =>
      safeAsyncCall(() => _dataSource.getRevision(id));

  @override
  Future<Result<RevisionQuotaModel>> getQuota() =>
      safeAsyncCall(_dataSource.getQuota);

  @override
  Future<Result<RevisionModel>> createRevision(
    CreateRevisionRequest request,
  ) =>
      safeAsyncCall(() => _dataSource.createRevision(request));
}
