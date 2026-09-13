import 'package:equatable/equatable.dart';

import '../portfolio/walkthrough_response_model.dart';
import 'blueprint_response_model.dart';
import 'render_response_model.dart';

class DeliverablesResponseModel extends Equatable {
  const DeliverablesResponseModel({
    this.blueprints,
    this.renders,
    this.walkthroughs,
    this.projectName,
    this.projectThumbnailUrl,
    this.allFilesZipUrl,
  });

  final List<BlueprintResponseModel>? blueprints;
  final List<RenderResponseModel>? renders;
  final List<WalkthroughResponseModel>? walkthroughs;
  final String? projectName;
  final String? projectThumbnailUrl;
  final String? allFilesZipUrl;

  factory DeliverablesResponseModel.fromJson(Map<String, dynamic> json) {
    return DeliverablesResponseModel(
      blueprints: (json['blueprints'] as List?)
          ?.whereType<Map>()
          .map(
            (item) =>
                BlueprintResponseModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
      renders: (json['renders'] as List?)
          ?.whereType<Map>()
          .map(
            (item) =>
                RenderResponseModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
      walkthroughs: (json['walkthroughs'] as List?)
          ?.whereType<Map>()
          .map(
            (item) => WalkthroughResponseModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
      projectName: json['projectName']?.toString(),
      projectThumbnailUrl: json['projectThumbnailUrl']?.toString(),
      allFilesZipUrl: json['allFilesZipUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'blueprints': blueprints?.map((e) => e.toJson()).toList(),
    'renders': renders?.map((e) => e.toJson()).toList(),
    'walkthroughs': walkthroughs?.map((e) => e.toJson()).toList(),
    'projectName': projectName,
    'projectThumbnailUrl': projectThumbnailUrl,
    'allFilesZipUrl': allFilesZipUrl,
  };

  @override
  List<Object?> get props => [
    blueprints,
    renders,
    walkthroughs,
    projectName,
    projectThumbnailUrl,
    allFilesZipUrl,
  ];

  @override
  String toString() {
    return 'DeliverablesResponseModel('
        'projectName: $projectName, '
        'blueprintsCount: ${blueprints?.length}, '
        'rendersCount: ${renders?.length}, '
        'walkthroughsCount: ${walkthroughs?.length}'
        ')';
  }
}
