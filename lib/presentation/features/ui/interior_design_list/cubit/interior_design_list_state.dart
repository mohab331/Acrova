import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/interior_design_filter_enum.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:equatable/equatable.dart';

class InteriorDesignListState extends Equatable {
  const InteriorDesignListState({
    this.cubitStatus = CubitStatus.initial,
    this.appErrorModel,
    this.items,
    this.filter = InteriorDesignFilter.all,
  });

  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;
  final List<InteriorDesignResponseModel>? items;
  final InteriorDesignFilter filter;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  List<InteriorDesignResponseModel> get filteredItems {
    final all = items ?? const [];
    return switch (filter) {
      InteriorDesignFilter.all => all,
      InteriorDesignFilter.active =>
        all.where((item) => !(item.status?.isTerminal ?? false)).toList(),
      InteriorDesignFilter.completed =>
        all.where((item) => (item.status?.isTerminal ?? false)).toList(),
    };
  }

  InteriorDesignListState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
    List<InteriorDesignResponseModel>? items,
    InteriorDesignFilter? filter,
  }) {
    return InteriorDesignListState(
      cubitStatus: cubitStatus ?? this.cubitStatus,
      appErrorModel: appErrorModel ?? this.appErrorModel,
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [cubitStatus, appErrorModel, items, filter];
}
