import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BasePortfolioRepo {
  Future<Result<List<PortfolioItem>>> getPortfolioItems();
  Future<Result<PortfolioItem>> getPortfolioItemByID(String id);
}
