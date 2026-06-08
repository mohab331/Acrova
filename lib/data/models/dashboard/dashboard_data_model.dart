import 'package:acrova/data/models/project/project_model.dart';
import 'package:equatable/equatable.dart';

/// Typed dashboard data — replaces the loose `Map<String, dynamic>` approach.
class DashboardDataModel extends Equatable {
  const DashboardDataModel({
    required this.userName,
    required this.recentProjects,
    required this.exploreDesigns,
    this.notificationCount = 0,
    this.avatarUrl,
  });

  final String userName;
  final List<ProjectModel> recentProjects;
  final List<DesignModel> exploreDesigns;
  final int notificationCount;
  final String? avatarUrl;

  @override
  List<Object?> get props =>
      [userName, recentProjects, exploreDesigns, notificationCount];
}

/// Gallery/explore design tile.
class DesignModel extends Equatable {
  const DesignModel({
    required this.id,
    required this.title,
    required this.styleTag,
    this.imageAsset,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String styleTag;    // e.g. "MODERNISM"
  final String? imageAsset; // local asset path
  final String? imageUrl;   // remote URL (future)

  @override
  List<Object?> get props => [id, title, styleTag];
}
