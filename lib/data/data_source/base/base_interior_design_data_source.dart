import 'package:acrova/data/models/request/interior_design/get_interior_design_request_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';

abstract class BaseInteriorDesignDataSource {
  Future<List<InteriorDesignResponseModel>> getInteriorDesigns();
  Future<InteriorDesignResponseModel> getInteriorDesign(
    GetInteriorDesignRequestModel request,
  );
}
