import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/presentation/features/cubit/portfolio/portfolio_state.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_filter_row.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit({
    required BasePortfolioRepo portfolioRepo,
    BaseAuthRepo? authRepo,
  })  : _portfolioRepo = portfolioRepo,
        _authRepo = authRepo,
        super(const PortfolioState());

  final BasePortfolioRepo _portfolioRepo;
  final BaseAuthRepo? _authRepo;

  Future<void> fetchPortfolio() async {
    emit(state.copyWith(status: CubitStatus.loading));

    if (_authRepo != null) {
      final profileResult = await _authRepo.getUserProfile();
      profileResult.when(
        success: (profile) {
          emit(state.copyWith(
            userName: profile.name.isNotEmpty ? profile.name : 'Client',
            avatarUrl: profile.avatarUrl,
          ));
        },
        failure: (_) {},
      );
    }

    final result = await _portfolioRepo.getPortfolioItems();
    result.when(
      success: (items) {
        emit(state.copyWith(status: CubitStatus.success, items: items));
      },
      failure: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }

  void setFilter(PortfolioFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
