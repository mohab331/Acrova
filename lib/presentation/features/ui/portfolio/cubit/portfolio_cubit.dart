import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit({
    required BasePortfolioRepo portfolioRepo,
    BaseAuthRepo? authRepo,
  }) : _portfolioRepo = portfolioRepo,
       super(const PortfolioState());

  final BasePortfolioRepo _portfolioRepo;

  Future<void> fetchPortfolio() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await _portfolioRepo.getPortfolioItems();
    result.when(
      success: (data) {
        final filters = ['all', ...data.map((e) => e.category ?? '').toSet()];
        emit(
          state.copyWith(
            status: CubitStatus.success,
            items: data,
            filters: filters,
            filter: 'all',
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }

  void setFilter(String? filter) {
    emit(state.copyWith(filter: filter));
  }
}
