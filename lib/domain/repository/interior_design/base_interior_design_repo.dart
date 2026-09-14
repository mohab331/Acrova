import 'package:acrova/data/models/request/interior_design/get_interior_design_request_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseInteriorDesignRepo {
  Future<Result<List<InteriorDesignResponseModel>>> getInteriorDesigns();
  Future<Result<InteriorDesignResponseModel>> getInteriorDesign(
    GetInteriorDesignRequestModel request,
  );
}
