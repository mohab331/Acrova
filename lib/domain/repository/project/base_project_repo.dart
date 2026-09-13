import 'package:acrova/data/models/request/project/create_project_request_model.dart';
import 'package:acrova/data/models/request/project/get_project_request_model.dart';
import 'package:acrova/data/models/request/project/interior_design_request_model.dart';
import 'package:acrova/data/models/response/project/moodboard_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseProjectRepo {
  Future<Result<List<ProjectResponseModel>>> getProjects();
  Future<Result<ProjectResponseModel>> getProject(GetProjectRequestModel request);
  Future<Result<ProjectResponseModel>> createProject(CreateProjectRequestModel request);
  Future<Result<void>> submitInteriorDesign(InteriorDesignRequestModel request);
  Future<Result<List<MoodboardResponseModel>>> getMoodboards();
}
