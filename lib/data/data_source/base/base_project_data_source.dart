import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/project_model.dart';

abstract class BaseProjectDataSource {
  Future<DashboardDataModel> getDashboard();
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> getProject(String id);
  Future<ProjectModel> createProject(CreateProjectRequest request);
}
