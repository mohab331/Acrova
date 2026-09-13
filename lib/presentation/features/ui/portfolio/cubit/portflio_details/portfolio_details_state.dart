import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class PortfolioDetailsState extends Equatable {
  const PortfolioDetailsState({
    this.cubitStatus = CubitStatus.initial,
    this.appErrorModel,
    this.portfolioItem,
  });

  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;
  final PortfolioItem? portfolioItem;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  PortfolioDetailsState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
    PortfolioItem? portfolioItem,
  }) {
    return PortfolioDetailsState(
      cubitStatus: cubitStatus ?? this.cubitStatus,
      appErrorModel: appErrorModel ?? this.appErrorModel,
      portfolioItem: portfolioItem ?? this.portfolioItem,
    );
  }

  @override
  List<Object?> get props => [cubitStatus, portfolioItem, appErrorModel];
}
