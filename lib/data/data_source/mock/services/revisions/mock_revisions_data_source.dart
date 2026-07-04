import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/models/request/revision/create_revision_request.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/data/models/revision/revision_quota_model.dart';
import 'package:acrova/utils/enums/revision_status_enum.dart';

class MockRevisionsDataSource implements BaseRevisionsDataSource {
  final List<RevisionModel> _revisions = [
    RevisionModel(
      id: 'REV-003',
      status: RevisionStatus.inProgress,
      createdAt: DateTime(2023, 10, 24),
      description:
          'Adjusted Majlis dimensions to accommodate the revised seating arrangement requested during the last conceptual review. Extended the western elevation glazing to maximize evening light penetration.',
      collaborators: const ['FA', 'MK'],
      engineerName: 'Eng. Ahmad Al-Harbi',
      engineerRole: 'Lead Structural Engineer',
      engineerNote:
          'The structural integrity for the extended glazing has been verified. The floor area remains within municipal limits.',
    ),
    RevisionModel(
      id: 'REV-002',
      status: RevisionStatus.completed,
      createdAt: DateTime(2023, 10, 12),
      description:
          'Material specification update for the primary facade. Replaced the proposed travertine with honed Omani limestone as per environmental durability requirements.',
      collaborators: const ['SA'],
      engineerName: 'Eng. Sara Al-Amri',
      engineerRole: 'Materials Specialist',
      engineerNote:
          'Limestone samples approved. Updated specifications shared with the contractor.',
    ),
    RevisionModel(
      id: 'REV-001',
      status: RevisionStatus.completed,
      createdAt: DateTime(2023, 9, 5),
      description:
          'Initial conceptual design review notes applied. Reoriented the primary structure axis by 4 degrees to optimize views toward the Wadi while maintaining privacy from the adjacent plot.',
      collaborators: const ['MK', 'HA'],
      engineerName: 'Eng. Mohammed Khalid',
      engineerRole: 'Senior Architect',
      engineerNote:
          'Axis reorientation finalized and reflected across all deliverables.',
    ),
  ];

  @override
  Future<List<RevisionModel>> getRevisions() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return List.unmodifiable(_revisions);
  }

  @override
  Future<RevisionModel> getRevision(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _revisions.firstWhere((r) => r.id == id);
  }

  @override
  Future<RevisionQuotaModel> getQuota() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return const RevisionQuotaModel(used: 3, total: 3, paidCost: 1500);
  }

  @override
  Future<RevisionModel> createRevision(CreateRevisionRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    final seq = (_revisions.length + 1).toString().padLeft(3, '0');
    final revision = RevisionModel(
      id: 'REV-$seq',
      status: RevisionStatus.inProgress,
      createdAt: DateTime.now(),
      description: request.details,
    );
    _revisions.insert(0, revision);
    return revision;
  }
}
