import 'package:acrova/data/models/interior_design/moodboard_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/interior_design_request.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseProjectRepo {
  Future<Result<List<ProjectModel>>> getProjects();
  Future<Result<ProjectModel>> getProject(String id);
  Future<Result<ProjectModel>> createProject(CreateProjectRequest request);
  Future<Result<void>> submitInteriorDesign(InteriorDesignRequest request);
  Future<Result<List<MoodboardModel>>> getMoodboards();
}
