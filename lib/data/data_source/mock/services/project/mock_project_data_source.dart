import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';

class MockProjectDataSource implements BaseProjectDataSource {
  // Mutable list so createProject can append to it.
  final List<ProjectModel> _projects = [
    ProjectModel(
      id: 'ARC-2024-00018',
      name: 'Al-Yasmeen Estate',
      status: ProjectStatus.awaitingPricing,
      type: ProjectType.residentialVilla,
      createdAt: DateTime(2024, 11, 3),
      location: 'Al-Yasmeen District, Riyadh',
      landAreaSqm: 380,
      floors: 2,
      thumbnailUrl:
          'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg', // will use local asset placeholder
    ),
    ProjectModel(
      id: 'ARC-2024-00021',
      name: 'Nakheel Commercial Tower',
      status: ProjectStatus.awaitingEngineering,
      type: ProjectType.commercialBuilding,
      createdAt: DateTime(2024, 12, 15),
      location: 'King Abdullah Road, Jeddah',
      landAreaSqm: 850,
      floors: 4,
      thumbnailUrl:
          'https://himajaconstructions.com/wp-content/uploads/2025/12/A.ELITE-ICON-SOUTH-EAST-ELEVATION-VIEW.jpg',
    ),
    ProjectModel(
      id: 'ARC-2025-00003',
      name: 'Rawdah Villa',
      status: ProjectStatus.deliverablesReady,
      type: ProjectType.residentialVilla,
      createdAt: DateTime(2025, 1, 20),
      location: 'Al-Rawdah, Riyadh',
      landAreaSqm: 560,
      floors: 3,
      thumbnailUrl: 'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg'
      ,
    ),
  ];

  @override
  Future<DashboardDataModel> getDashboard() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return DashboardDataModel(
      userName: 'Mohab',
      recentProjects: _projects.take(2).toList(),
      notificationCount: 2,
      exploreDesigns: [
        DesignModel(
          id: '1',
          title: 'The Glass Pavilion',
          styleTag: 'MODERNISM',
          imageAsset: Resources.drawables.design1,
        ),
        DesignModel(
          id: '2',
          title: 'Al-Andalus Mansion',
          styleTag: 'CLASSIC',
          imageAsset: Resources.drawables.img1,
        ),
        DesignModel(
          id: '3',
          title: 'Desert Minimalism',
          styleTag: 'MINIMALIST',
          imageAsset: Resources.drawables.img2,
        ),
      ],
    );
  }

  @override
  Future<List<ProjectModel>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_projects);
  }

  @override
  Future<ProjectModel> getProject(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _projects.firstWhere((p) => p.id == id);
  }

  @override
  Future<ProjectModel> createProject(CreateProjectRequest request) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    final now = DateTime.now();
    final seqN = (_projects.length + 1).toString().padLeft(5, '0');
    final newId = 'ARC-${now.year}-$seqN';

    final project = ProjectModel(
      id: newId,
      name: '${request.projectType.displayLabel} — ${request.location}',
      status: ProjectStatus.awaitingPricing,
      type: request.projectType,
      createdAt: now,
      location: request.location,
      landAreaSqm: request.landAreaSqm,
      floors: request.floors,
    );

    _projects.add(project);
    return project;
  }
}
