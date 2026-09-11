import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/utils/helpers/result.dart';

class PortfolioRepoImpl implements BasePortfolioRepo {
  PortfolioRepoImpl();

  @override
  Future<Result<List<PortfolioItem>>> getPortfolioItems() async {
    return const Success([]);
  }
}
