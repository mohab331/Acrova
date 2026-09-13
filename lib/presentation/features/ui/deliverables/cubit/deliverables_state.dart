import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/deliverables/blueprint_response_model.dart';
import 'package:acrova/data/models/response/deliverables/render_response_model.dart';
import 'package:acrova/data/models/response/portfolio/walkthrough_response_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

typedef BlueprintModel = BlueprintResponseModel;

typedef RenderModel = RenderResponseModel;

class WalkthroughVersionModel extends Equatable {
  const WalkthroughVersionModel({
    required this.version,
    required this.dateAndSize,
  });
  final String version;
  final String dateAndSize;

  @override
  List<Object?> get props => [version, dateAndSize];
}

class DeliverablesState extends Equatable {
  const DeliverablesState({
    this.status = CubitStatus.initial,
    this.error,
    this.blueprints = const [],
    this.renders = const [],
    this.walkthroughs = const [],
    this.projectName,
    this.projectThumbnailUrl,
    this.allFilesZipUrl,
  });

  final CubitStatus status;
  final AppErrorModel? error;
  final List<BlueprintResponseModel> blueprints;
  final List<RenderResponseModel> renders;
  final List<WalkthroughResponseModel> walkthroughs;
  final String? projectName;
  final String? projectThumbnailUrl;
  final String? allFilesZipUrl;

  bool get isLoading =>
      status == CubitStatus.loading || status == CubitStatus.initial;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;

  DeliverablesState copyWith({
    CubitStatus? status,
    AppErrorModel? error,
    List<BlueprintResponseModel>? blueprints,
    List<RenderResponseModel>? renders,
    List<WalkthroughResponseModel>? walkthroughs,
    String? projectName,
    String? projectThumbnailUrl,
    String? allFilesZipUrl,
  }) {
    return DeliverablesState(
      status: status ?? this.status,
      error: error ?? this.error,
      blueprints: blueprints ?? this.blueprints,
      renders: renders ?? this.renders,
      walkthroughs: walkthroughs ?? this.walkthroughs,
      projectName: projectName ?? this.projectName,
      projectThumbnailUrl: projectThumbnailUrl ?? this.projectThumbnailUrl,
      allFilesZipUrl: allFilesZipUrl ?? this.allFilesZipUrl,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    blueprints,
    renders,
    walkthroughs,
    projectName,
    projectThumbnailUrl,
    allFilesZipUrl,
  ];
}
