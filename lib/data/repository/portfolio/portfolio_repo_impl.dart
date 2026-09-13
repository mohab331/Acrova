import 'package:acrova/data/models/request/portfolio/get_portfolio_item_request_model.dart';
import 'package:acrova/data/models/response/portfolio/portfolio_item_response_model.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/utils/helpers/result.dart';

class PortfolioRepoImpl implements BasePortfolioRepo {
  PortfolioRepoImpl();

  @override
  Future<Result<List<PortfolioItemResponseModel>>> getPortfolioItems() async {
    throw UnimplementedError();
  }

  @override
  Future<Result<PortfolioItemResponseModel>> getPortfolioItemByID(
    GetPortfolioItemRequestModel request,
  ) {
    throw UnimplementedError();
  }
}
