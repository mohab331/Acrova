import 'package:acrova/data/models/request/project/create_project_request_model.dart';
import 'package:acrova/data/models/request/project/get_project_request_model.dart';
import 'package:acrova/data/models/request/project/interior_design_request_model.dart';
import 'package:acrova/data/models/response/project/moodboard_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';

abstract class BaseProjectDataSource {
  Future<List<ProjectResponseModel>> getProjects();
  Future<ProjectResponseModel> getProject(GetProjectRequestModel request);
  Future<ProjectResponseModel> createProject(CreateProjectRequestModel request);
  Future<void> submitInteriorDesign(InteriorDesignRequestModel request);
  Future<List<MoodboardResponseModel>> getMoodboards();
}
