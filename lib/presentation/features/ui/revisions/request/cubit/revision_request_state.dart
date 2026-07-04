import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/data/models/revision/revision_quota_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/revision_category_enum.dart';
import 'package:equatable/equatable.dart';

class RevisionRequestState extends Equatable {
  const RevisionRequestState({
    required this.cubitStatus,
    this.quota,
    this.deliverableRef,
    this.details = '',
    this.attachmentPaths = const [],
    this.categoryError,
    this.detailsError,
    this.isSubmitting = false,
    this.createdRevision,
    this.appErrorModel,
  });

  const RevisionRequestState.initial()
      : this(cubitStatus: CubitStatus.initial);

  /// Tracks the quota load (loading → skeleton, error → error, success → form).
  final CubitStatus cubitStatus;
  final RevisionQuotaModel? quota;

  final String? deliverableRef;
  final String details;
  final List<String> attachmentPaths;

  final String? categoryError;
  final String? detailsError;

  final bool isSubmitting;
  final RevisionModel? createdRevision;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError   => cubitStatus == CubitStatus.error;

  RevisionRequestState copyWith({
    CubitStatus? cubitStatus,
    RevisionQuotaModel? quota,
    RevisionCategory? Function()? selectedCategory,
    String? Function()? deliverableRef,
    String? details,
    List<String>? attachmentPaths,
    String? Function()? categoryError,
    String? Function()? detailsError,
    bool? isSubmitting,
    RevisionModel? createdRevision,
    AppErrorModel? appErrorModel,
  }) =>
      RevisionRequestState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        quota: quota ?? this.quota,

        deliverableRef:
            deliverableRef != null ? deliverableRef() : this.deliverableRef,
        details: details ?? this.details,
        attachmentPaths: attachmentPaths ?? this.attachmentPaths,
        categoryError:
            categoryError != null ? categoryError() : this.categoryError,
        detailsError: detailsError != null ? detailsError() : this.detailsError,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        createdRevision: createdRevision ?? this.createdRevision,
        appErrorModel: appErrorModel,
      );

  @override
  List<Object?> get props => [
        cubitStatus,
        quota,
        deliverableRef,
        details,
        attachmentPaths,
        categoryError,
        detailsError,
        isSubmitting,
        createdRevision,
        appErrorModel,
      ];
}
