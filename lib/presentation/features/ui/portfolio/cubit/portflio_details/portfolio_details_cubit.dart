import 'package:acrova/data/models/request/portfolio/get_portfolio_item_request_model.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portflio_details/portfolio_details_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioDetailsCubit extends Cubit<PortfolioDetailsState> {
  PortfolioDetailsCubit({required BasePortfolioRepo portfolioRepo})
    : _portfolioRepo = portfolioRepo,
      super(const PortfolioDetailsState());

  final BasePortfolioRepo _portfolioRepo;

  Future<void> fetchPortfolio({required String? portfolioId}) async {
    if (portfolioId == null || portfolioId.isEmpty) return;

    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final result = await _portfolioRepo.getPortfolioItemByID(
      GetPortfolioItemRequestModel(id: portfolioId),
    );
    result.when(
      success: (data) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.success, portfolioItem: data),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }
}
