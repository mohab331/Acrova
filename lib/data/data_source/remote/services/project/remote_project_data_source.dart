import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/interior_design/moodboard_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/interior_design_request.dart';
import 'package:acrova/data/models/project/project_model.dart';

class RemoteProjectDataSource implements BaseProjectDataSource {
  RemoteProjectDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<ProjectModel>> getProjects() async {
    throw UnimplementedError('Remote getProjects not implemented yet');
  }

  @override
  Future<ProjectModel> getProject(String id) async {
    throw UnimplementedError('Remote getProject not implemented yet');
  }

  @override
  Future<ProjectModel> createProject(CreateProjectRequest request) async {
    throw UnimplementedError('Remote createProject not implemented yet');
  }

  @override
  Future<void> submitInteriorDesign(InteriorDesignRequest request) async {
    throw UnimplementedError('Remote submitInteriorDesign not implemented yet');
  }

  @override
  Future<List<MoodboardModel>> getMoodboards() async {
    throw UnimplementedError('Remote getMoodboards not implemented yet');
  }
}
