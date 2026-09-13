import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/portfolio/portfolio_item_response_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PortfolioState extends Equatable {
  const PortfolioState({
    this.status = CubitStatus.initial,
    this.items = const [],
    this.filter,
    this.error,
    this.filters = const [],
  });

  final CubitStatus status;
  final List<PortfolioItemResponseModel> items;
  final AppErrorModel? error;
  final String? filter;
  final List<String> filters;

  bool get isLoading =>
      status == CubitStatus.loading || status == CubitStatus.initial;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;

  List<PortfolioItemResponseModel> getFilteredItems(BuildContext context) {
    if (filter?.toLowerCase().trim() ==
        context.localization.filterAll.toLowerCase().trim()) {
      return items;
    }
    return items
        .where(
          (i) =>
              i.category?.toLowerCase().trim() == filter?.toLowerCase().trim(),
        )
        .toList();
  }

  PortfolioState copyWith({
    CubitStatus? status,
    List<PortfolioItemResponseModel>? items,
    String? filter,
    AppErrorModel? error,
    List<String>? filters,
  }) {
    return PortfolioState(
      status: status ?? this.status,
      items: items ?? this.items,
      filter: filter ?? this.filter,
      error: error ?? this.error,
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object?> get props => [status, items, filter, error, filters];
}
