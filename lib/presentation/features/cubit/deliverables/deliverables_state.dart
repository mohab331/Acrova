import 'package:acrova/core/error/app_error_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/enums/cubit_status.dart' show CubitStatus;

// Simple mock models for UI representation
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
  const RenderModel({
    required this.resolution,
    required this.imageAsset,
  });
  final String resolution;
  final String imageAsset;

  @override
  List<Object?> get props => [resolution, imageAsset];
}

class WalkthroughModel extends Equatable {
  const WalkthroughModel({
    required this.title,
    required this.duration,
    required this.size,
    required this.format,
    required this.imageAsset,
  });
  final String title;
  final String duration;
  final String size;
  final String format;
  final String imageAsset;

  @override
  List<Object?> get props => [title, duration, size, format, imageAsset];
}

class DeliverablesState extends Equatable {
  const DeliverablesState({
    this.status = CubitStatus.initial,
    this.error,
    this.blueprints = const [],
    this.renders = const [],
    this.walkthroughs = const [],
  });

  final CubitStatus status;
  final AppErrorModel? error;
  final List<BlueprintModel> blueprints;
  final List<RenderModel> renders;
  final List<WalkthroughModel> walkthroughs;

  DeliverablesState copyWith({
    CubitStatus? status,
    AppErrorModel? error,
    List<BlueprintModel>? blueprints,
    List<RenderModel>? renders,
    List<WalkthroughModel>? walkthroughs,
  }) {
    return DeliverablesState(
      status: status ?? this.status,
      error: error ?? this.error,
      blueprints: blueprints ?? this.blueprints,
      renders: renders ?? this.renders,
      walkthroughs: walkthroughs ?? this.walkthroughs,
    );
  }

  @override
  List<Object?> get props => [status, error, blueprints, renders, walkthroughs];
}
