import 'package:acrova/data/models/request/portfolio/get_portfolio_item_request_model.dart';
import 'package:acrova/data/models/response/portfolio/portfolio_item_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BasePortfolioRepo {
  Future<Result<List<PortfolioItemResponseModel>>> getPortfolioItems();
  Future<Result<PortfolioItemResponseModel>> getPortfolioItemByID(
    GetPortfolioItemRequestModel request,
  );
}
