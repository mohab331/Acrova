import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class ProjectRepoImpl implements BaseProjectRepo {
  const ProjectRepoImpl({required BaseProjectDataSource dataSource})
      : _dataSource = dataSource;

  final BaseProjectDataSource _dataSource;

  @override
  Future<Result<DashboardDataModel>> getDashboard() =>
      safeAsyncCall(_dataSource.getDashboard);

  @override
  Future<Result<List<ProjectModel>>> getProjects() =>
      safeAsyncCall(_dataSource.getProjects);

  @override
  Future<Result<ProjectModel>> getProject(String id) =>
      safeAsyncCall(() => _dataSource.getProject(id));

  @override
  Future<Result<ProjectModel>> createProject(CreateProjectRequest request) =>
      safeAsyncCall(() => _dataSource.createProject(request));
}
