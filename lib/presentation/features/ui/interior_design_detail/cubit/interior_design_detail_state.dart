import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class InteriorDesignDetailState extends Equatable {
  const InteriorDesignDetailState({
    this.cubitStatus = CubitStatus.initial,
    this.id,
    this.appErrorModel,
    this.item,
  });

  final CubitStatus cubitStatus;
  final String? id;
  final AppErrorModel? appErrorModel;
  final InteriorDesignResponseModel? item;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  InteriorDesignDetailState copyWith({
    CubitStatus? cubitStatus,
    String? id,
    AppErrorModel? appErrorModel,
    InteriorDesignResponseModel? item,
  }) {
    return InteriorDesignDetailState(
      cubitStatus: cubitStatus ?? this.cubitStatus,
      id: id ?? this.id,
      appErrorModel: appErrorModel ?? this.appErrorModel,
      item: item ?? this.item,
    );
  }

  @override
  List<Object?> get props => [cubitStatus, id, appErrorModel, item];
}
