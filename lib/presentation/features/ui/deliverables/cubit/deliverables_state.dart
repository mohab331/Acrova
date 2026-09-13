import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class BlueprintModel extends Equatable {
  const BlueprintModel({
    required this.title,
    required this.size,
    required this.format,
    required this.urlOrAsset,
  });
  final String title;
  final String size;
  final String format;
  final String urlOrAsset;

  @override
  List<Object?> get props => [title, size, format, urlOrAsset];
}

class RenderModel extends Equatable {
  const RenderModel({required this.resolution, required this.imageAsset});
  final String resolution;
  final String imageAsset;

  @override
  List<Object?> get props => [resolution, imageAsset];
}

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
  final List<BlueprintModel> blueprints;
  final List<RenderModel> renders;
  final List<WalkthroughModel> walkthroughs;
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
    List<BlueprintModel>? blueprints,
    List<RenderModel>? renders,
    List<WalkthroughModel>? walkthroughs,
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
