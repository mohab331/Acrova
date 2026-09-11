import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/portfolio_filter_enum.dart';
import 'package:equatable/equatable.dart';

class PortfolioState extends Equatable {
  const PortfolioState({
    this.status = CubitStatus.initial,
    this.items = const [],
    this.filter = PortfolioFilter.all,
    this.error,
    this.userName,
    this.notificationCount = 0,
    this.avatarUrl,
  });

  final CubitStatus status;
  final List<PortfolioItem> items;
  final PortfolioFilter filter;
  final AppErrorModel? error;
  final String? userName;
  final int notificationCount;
  final String? avatarUrl;

  bool get isLoading =>
      status == CubitStatus.loading || status == CubitStatus.initial;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;

  List<PortfolioItem> get filteredItems {
    if (filter == PortfolioFilter.all) return items;
    return items
        .where(
          (i) =>
              i.category.toLowerCase() == filter.value.toLowerCase() ||
              i.category.toLowerCase() == filter.name.toLowerCase(),
        )
        .toList();
  }

  PortfolioState copyWith({
    CubitStatus? status,
    List<PortfolioItem>? items,
    PortfolioFilter? filter,
    AppErrorModel? error,
    String? userName,
    int? notificationCount,
    String? avatarUrl,
  }) {
    return PortfolioState(
      status: status ?? this.status,
      items: items ?? this.items,
      filter: filter ?? this.filter,
      error: error ?? this.error,
      userName: userName ?? this.userName,
      notificationCount: notificationCount ?? this.notificationCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    filter,
    error,
    userName,
    notificationCount,
    avatarUrl,
  ];
}
