import 'package:acrova/data/models/interior_design/moodboard_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/interior_design_request.dart';
import 'package:acrova/data/models/project/project_model.dart';

abstract class BaseProjectDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> getProject(String id);
  Future<ProjectModel> createProject(CreateProjectRequest request);
  Future<void> submitInteriorDesign(InteriorDesignRequest request);
  Future<List<MoodboardModel>> getMoodboards();
}
