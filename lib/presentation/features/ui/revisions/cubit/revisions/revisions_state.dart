import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class RevisionsCubitState extends Equatable {
  const RevisionsCubitState({
    required this.cubitStatus,
    this.revisions,
    this.appErrorModel,
  });

  const RevisionsCubitState.initial()
      : this(cubitStatus: CubitStatus.initial);

  final CubitStatus cubitStatus;
  final List<RevisionModel>? revisions;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError   => cubitStatus == CubitStatus.error;
  bool get isEmpty => (revisions ?? const []).isEmpty;

  RevisionsCubitState copyWith({
    CubitStatus? cubitStatus,
    List<RevisionModel>? revisions,
    AppErrorModel? appErrorModel,
  }) =>
      RevisionsCubitState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        revisions: revisions ?? this.revisions,
        appErrorModel: appErrorModel,
      );

  @override
  List<Object?> get props => [cubitStatus, revisions, appErrorModel];
}
