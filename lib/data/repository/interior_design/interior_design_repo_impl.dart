import 'package:acrova/data/data_source/base/base_interior_design_data_source.dart';
import 'package:acrova/data/models/request/interior_design/get_interior_design_request_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/domain/repository/interior_design/base_interior_design_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class InteriorDesignRepoImpl implements BaseInteriorDesignRepo {
  final BaseInteriorDesignDataSource _dataSource;

  InteriorDesignRepoImpl({required BaseInteriorDesignDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Result<List<InteriorDesignResponseModel>>> getInteriorDesigns() =>
      safeAsyncCall(_dataSource.getInteriorDesigns);

  @override
  Future<Result<InteriorDesignResponseModel>> getInteriorDesign(
    GetInteriorDesignRequestModel request,
  ) => safeAsyncCall(() => _dataSource.getInteriorDesign(request));
}
