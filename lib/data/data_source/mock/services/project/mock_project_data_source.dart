import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/deliverable_model.dart';
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
      type: ProjectType.villa,
      createdAt: DateTime(2024, 11, 3),
      location: 'Al-Yasmeen District, Riyadh',
      landAreaSqm: 380,
      floors: 2,
      thumbnailUrl:
          'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
      bedrooms: 5,
      bathrooms: 6,
      hasMajlis: true,
      hasMaidRoom: true,
      hasDriverRoom: true,
      hasBasement: false,
      hasPool: true,
      hasRooftop: true,
      smartHomeLevel: 'advanced',
      architecturalStyle: 'Modern',
      landWidthM: 20,
      landLengthM: 19,
      deliverables: [
        DeliverableModel(
          id: 'd1',
          title: 'Floor Plan - Ground Floor',
          type: DeliverableType.pdf,
          url: 'https://example.com/floor_plan_ground.pdf',
          createdAt: DateTime(2024, 11, 10),
        ),
        DeliverableModel(
          id: 'd2',
          title: '3D Render - Facade',
          type: DeliverableType.image,
          url: 'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
          createdAt: DateTime(2024, 11, 12),
        ),
      ],
    ),
    ProjectModel(
      id: 'ARC-2024-00021',
      name: 'Nakheel Commercial Tower',
      status: ProjectStatus.awaitingEngineering,
      type: ProjectType.commercial,
      createdAt: DateTime(2024, 12, 15),
      location: 'King Abdullah Road, Jeddah',
      landAreaSqm: 850,
      floors: 4,
      thumbnailUrl:
          'https://himajaconstructions.com/wp-content/uploads/2025/12/A.ELITE-ICON-SOUTH-EAST-ELEVATION-VIEW.jpg',
      employeeCount: 150,
      hasBasement: true,
      smartHomeLevel: 'basic',
      architecturalStyle: 'Industrial',
      deliverables: [
        DeliverableModel(
          id: 'd3',
          title: 'Walkthrough Video',
          type: DeliverableType.video,
          url: 'https://example.com/walkthrough.mp4',
          createdAt: DateTime(2024, 12, 20),
        ),
      ],
    ),
    ProjectModel(
      id: 'ARC-2025-00003',
      name: 'Rawdah Villa',
      status: ProjectStatus.deliverablesReady,
      type: ProjectType.villa,
      createdAt: DateTime(2025, 1, 20),
      location: 'Al-Rawdah, Riyadh',
      landAreaSqm: 560,
      floors: 3,
      thumbnailUrl: 'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg'
      ,
    ),
    ProjectModel(
      id: 'ARC-2025-00004',
      name: 'Malqa Duplexes',
      status: ProjectStatus.awaitingPayment,
      type: ProjectType.commercial,
      createdAt: DateTime(2025, 2, 10),
      location: 'Al-Malqa, Riyadh',
      landAreaSqm: 600,
      floors: 2,
      thumbnailUrl: 'https://himajaconstructions.com/wp-content/uploads/2025/12/A.ELITE-ICON-SOUTH-EAST-ELEVATION-VIEW.jpg',
    ),
    ProjectModel(
      id: 'ARC-2025-00005',
      name: 'Sahafa Complex',
      status: ProjectStatus.paymentUnderReview,
      type: ProjectType.commercial,
      createdAt: DateTime(2025, 2, 12),
      location: 'Al-Sahafa, Riyadh',
      landAreaSqm: 1200,
      floors: 5,
      thumbnailUrl: 'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
    ),
    ProjectModel(
      id: 'ARC-2025-00006',
      name: 'Qurtubah Center',
      status: ProjectStatus.awaitingEngineeringAssignment,
      type: ProjectType.commercial,
      createdAt: DateTime(2025, 2, 18),
      location: 'Qurtubah, Riyadh',
      landAreaSqm: 1500,
      floors: 3,
      thumbnailUrl: 'https://himajaconstructions.com/wp-content/uploads/2025/12/A.ELITE-ICON-SOUTH-EAST-ELEVATION-VIEW.jpg',
    ),
    ProjectModel(
      id: 'ARC-2025-00007',
      name: 'Narjis Villa',
      status: ProjectStatus.revisionInProgress,
      type: ProjectType.villa,
      createdAt: DateTime(2025, 3),
      location: 'Al-Narjis, Riyadh',
      landAreaSqm: 450,
      floors: 2,
      thumbnailUrl: 'https://api.alhilwa.com.iq/uploads/projects/1774287086738-7ff23182f9452cf20ab58038546a.jpg',
    ),
    ProjectModel(
      id: 'ARC-2023-00099',
      name: 'Olaya Tower',
      status: ProjectStatus.completed,
      type: ProjectType.commercial,
      createdAt: DateTime(2023, 6, 15),
      location: 'Olaya, Riyadh',
      landAreaSqm: 2500,
      floors: 10,
      thumbnailUrl: 'https://himajaconstructions.com/wp-content/uploads/2025/12/A.ELITE-ICON-SOUTH-EAST-ELEVATION-VIEW.jpg',
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
      landWidthM: request.landWidthM,
      landLengthM: request.landLengthM,
      floors: request.floors,
      employeeCount: request.employeeCount,
      bedrooms: request.bedrooms,
      bathrooms: request.bathrooms,
      hasMajlis: request.hasMajlis,
      hasMaidRoom: request.hasMaidRoom,
      hasDriverRoom: request.hasDriverRoom,
      hasBasement: request.hasBasement,
      hasPool: request.hasPool,
      hasRooftop: request.hasRooftop,
      smartHomeLevel: request.smartHomeLevel,
      architecturalStyle: request.architecturalStyle,
    );

    _projects.add(project);
    return project;
  }
}
