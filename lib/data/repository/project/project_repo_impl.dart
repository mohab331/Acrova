import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/models/request/project/create_project_request_model.dart';
import 'package:acrova/data/models/request/project/get_project_request_model.dart';
import 'package:acrova/data/models/request/project/interior_design_request_model.dart';
import 'package:acrova/data/models/response/project/moodboard_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class ProjectRepoImpl implements BaseProjectRepo {
  final BaseProjectDataSource _dataSource;

  ProjectRepoImpl({required BaseProjectDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Result<List<ProjectResponseModel>>> getProjects() =>
      safeAsyncCall(_dataSource.getProjects);

  @override
  Future<Result<ProjectResponseModel>> getProject(
    GetProjectRequestModel request,
  ) => safeAsyncCall(() => _dataSource.getProject(request));

  @override
  Future<Result<ProjectResponseModel>> createProject(
    CreateProjectRequestModel request,
  ) => safeAsyncCall(() => _dataSource.createProject(request));

  @override
  Future<Result<void>> submitInteriorDesign(
    InteriorDesignRequestModel request,
  ) => safeAsyncCall(() => _dataSource.submitInteriorDesign(request));

  @override
  Future<Result<List<MoodboardResponseModel>>> getMoodboards() =>
      safeAsyncCall(_dataSource.getMoodboards);
}
