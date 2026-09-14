import 'package:acrova/data/data_source/base/base_interior_design_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/request/interior_design/get_interior_design_request_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';

class RemoteInteriorDesignDataSource implements BaseInteriorDesignDataSource {
  RemoteInteriorDesignDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<InteriorDesignResponseModel>> getInteriorDesigns() async {
    throw UnimplementedError('Remote getInteriorDesigns not implemented yet');
  }

  @override
  Future<InteriorDesignResponseModel> getInteriorDesign(
    GetInteriorDesignRequestModel request,
  ) async {
    throw UnimplementedError('Remote getInteriorDesign not implemented yet');
  }
}
