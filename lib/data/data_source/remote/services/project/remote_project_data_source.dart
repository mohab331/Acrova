import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/request/project/create_project_request_model.dart';
import 'package:acrova/data/models/request/project/get_project_request_model.dart';
import 'package:acrova/data/models/request/project/interior_design_request_model.dart';
import 'package:acrova/data/models/response/project/moodboard_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';

class RemoteProjectDataSource implements BaseProjectDataSource {
  RemoteProjectDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<ProjectResponseModel>> getProjects() async {
    throw UnimplementedError('Remote getProjects not implemented yet');
  }

  @override
  Future<ProjectResponseModel> getProject(GetProjectRequestModel request) async {
    throw UnimplementedError('Remote getProject not implemented yet');
  }

  @override
  Future<ProjectResponseModel> createProject(
    CreateProjectRequestModel request,
  ) async {
    throw UnimplementedError('Remote createProject not implemented yet');
  }

  @override
  Future<void> submitInteriorDesign(InteriorDesignRequestModel request) async {
    throw UnimplementedError('Remote submitInteriorDesign not implemented yet');
  }

  @override
  Future<List<MoodboardResponseModel>> getMoodboards() async {
    throw UnimplementedError('Remote getMoodboards not implemented yet');
  }
}
