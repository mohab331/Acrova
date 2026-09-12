import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/presentation/features/cubit/portfolio/portfolio_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/portfolio_filter_enum.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit({
    required BasePortfolioRepo portfolioRepo,
    BaseAuthRepo? authRepo,
  }) : _portfolioRepo = portfolioRepo,
       _authRepo = authRepo,
       super(const PortfolioState());

  final BasePortfolioRepo _portfolioRepo;
  final BaseAuthRepo? _authRepo;

  Future<void> fetchPortfolio() async {
    emit(state.copyWith(status: CubitStatus.loading));

    if (_authRepo != null) {
      await safeAsync(
        operation: () async {
          final profileResult = await _authRepo.getUserProfile();
          profileResult.when(
            success: (profile) {
              emit(
                state.copyWith(
                  userName: (profile.name?.isNotEmpty ?? false)
                      ? profile.name
                      : null,
                  avatarUrl: profile.avatarUrl,
                ),
              );
            },
            failure: (error) {
              AppLogger.instance.logWarning(
                'Failed to load user profile in PortfolioCubit: ${error.message}',
              );
            },
          );
        },
        onError: (error) {
          AppLogger.instance.logWarning(
            'Exception loading user profile in PortfolioCubit: ${error.message}',
          );
        },
      );
    }

    await safeCubitCall<List<PortfolioItem>>(
      call: _portfolioRepo.getPortfolioItems,
      onSuccess: (items) {
        emit(state.copyWith(status: CubitStatus.success, items: items));
      },
      onError: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }

  void setFilter(PortfolioFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
