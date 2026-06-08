import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseProjectRepo {
  Future<Result<DashboardDataModel>> getDashboard();
  Future<Result<List<ProjectModel>>> getProjects();
  Future<Result<ProjectModel>> getProject(String id);
  Future<Result<ProjectModel>> createProject(CreateProjectRequest request);
}
