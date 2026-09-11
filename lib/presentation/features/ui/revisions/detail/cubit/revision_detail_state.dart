import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class RevisionDetailState extends Equatable {
  const RevisionDetailState({
    required this.cubitStatus,
    this.revision,
    this.appErrorModel,
  });

  const RevisionDetailState.initial({RevisionModel? revision})
      : this(
          cubitStatus:
              revision != null ? CubitStatus.success : CubitStatus.initial,
          revision: revision,
        );

  final CubitStatus cubitStatus;
  final RevisionModel? revision;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError   => cubitStatus == CubitStatus.error;

  RevisionDetailState copyWith({
    CubitStatus? cubitStatus,
    RevisionModel? revision,
    AppErrorModel? appErrorModel,
  }) =>
      RevisionDetailState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        revision: revision ?? this.revision,
        appErrorModel: appErrorModel,
      );

  @override
  List<Object?> get props => [cubitStatus, revision, appErrorModel];
}
