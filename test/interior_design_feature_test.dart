import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/data/models/request/interior_design/get_interior_design_request_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/data/models/response/project/engineer_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';
import 'package:acrova/domain/repository/interior_design/base_interior_design_repo.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/cubit/interior_design_detail_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/cubit/interior_design_detail_state.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/cubit/interior_design_list_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/cubit/interior_design_list_state.dart';
import 'package:acrova/utils/enums/budget_tier_enum.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/interior_design_filter_enum.dart';
import 'package:acrova/utils/enums/interior_design_scope_enum.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:acrova/utils/enums/project_timeline_enum.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test repository implementation that executes synchronously without delays.
class TestInteriorDesignRepo implements BaseInteriorDesignRepo {
  TestInteriorDesignRepo({
    this.shouldFail = false,
    List<InteriorDesignResponseModel>? items,
  }) : items = items ?? _defaultItems;

  final bool shouldFail;
  final List<InteriorDesignResponseModel> items;

  static final List<InteriorDesignResponseModel> _defaultItems = [
    InteriorDesignResponseModel(
      id: 'int_001',
      referenceNumber: 'INT-2024-001',
      projectId: 'proj_001',
      projectName: 'Villa Al-Nakheel',
      title: 'Interior Design - Villa Al-Nakheel',
      status: InteriorDesignStatus.inProgress,
      scope: InteriorDesignScope.all,
      budgetTier: BudgetTier.ultraLuxury,
      timeline: ProjectTimeline.threeToSixMonths,
      specificRooms: const ['Master Bedroom Suite', 'Majlis'],
      amountDue: 45000.0,
      createdAt: DateTime(2024, 2, 10),
    ),
    InteriorDesignResponseModel(
      id: 'int_002',
      referenceNumber: 'INT-2024-002',
      projectId: 'proj_002',
      projectName: 'Commercial Complex Al-Malqa',
      title: 'Interior Design - Al-Malqa Retail Hub',
      status: InteriorDesignStatus.completed,
      scope: InteriorDesignScope.specific,
      budgetTier: BudgetTier.premium,
      timeline: ProjectTimeline.asap,
      specificRooms: const ['Main Atrium Reception'],
      amountDue: 28000.0,
      createdAt: DateTime(2024, 2, 18),
    ),
  ];

  @override
  Future<Result<List<InteriorDesignResponseModel>>> getInteriorDesigns() async {
    await Future<void>.delayed(Duration.zero);
    if (shouldFail) {
      return const Failure(
        AppErrorModel(
          code: ErrorCodesEnum.network,
          title: 'Network Error',
          message: 'Failed to fetch interior designs',
        ),
      );
    }
    return Success(items);
  }

  @override
  Future<Result<InteriorDesignResponseModel>> getInteriorDesign(
    GetInteriorDesignRequestModel request,
  ) async {
    await Future<void>.delayed(Duration.zero);
    if (shouldFail) {
      return const Failure(
        AppErrorModel(
          code: ErrorCodesEnum.notFound,
          title: 'Not Found',
          message: 'Interior design not found',
        ),
      );
    }
    final match = items.firstWhere(
      (item) => item.id == request.id,
      orElse: () => items.first,
    );
    return Success(match);
  }
}

void main() {
  group('InteriorDesignStatus Enum Tests', () {
    test('fromId correctly maps all 7 integer IDs', () {
      expect(InteriorDesignStatus.fromId(1), InteriorDesignStatus.awaitingPricing);
      expect(InteriorDesignStatus.fromId(2), InteriorDesignStatus.awaitingPayment);
      expect(InteriorDesignStatus.fromId(3), InteriorDesignStatus.paymentUnderReview);
      expect(InteriorDesignStatus.fromId(4), InteriorDesignStatus.inProgress);
      expect(InteriorDesignStatus.fromId(5), InteriorDesignStatus.conceptReady);
      expect(InteriorDesignStatus.fromId(6), InteriorDesignStatus.revisionInProgress);
      expect(InteriorDesignStatus.fromId(7), InteriorDesignStatus.completed);
    });

    test('fromId returns null for invalid IDs without fallback default', () {
      expect(InteriorDesignStatus.fromId(null), isNull);
      expect(InteriorDesignStatus.fromId(0), isNull);
      expect(InteriorDesignStatus.fromId(8), isNull);
      expect(InteriorDesignStatus.fromId(-1), isNull);
      expect(InteriorDesignStatus.fromId(999), isNull);
    });

    test('fromValue parses ints, numeric strings, and name strings', () {
      expect(InteriorDesignStatus.fromValue(1), InteriorDesignStatus.awaitingPricing);
      expect(InteriorDesignStatus.fromValue('2'), InteriorDesignStatus.awaitingPayment);
      expect(InteriorDesignStatus.fromValue('inProgress'), InteriorDesignStatus.inProgress);
      expect(InteriorDesignStatus.fromValue('INPROGRESS'), InteriorDesignStatus.inProgress);
      expect(InteriorDesignStatus.fromValue('completed'), InteriorDesignStatus.completed);
      expect(InteriorDesignStatus.fromValue(null), isNull);
      expect(InteriorDesignStatus.fromValue('unknown_status'), isNull);
      expect(InteriorDesignStatus.fromValue(100), isNull);
    });

    test('fromJson delegates to fromValue', () {
      expect(InteriorDesignStatus.fromJson(4), InteriorDesignStatus.inProgress);
      expect(InteriorDesignStatus.fromJson('4'), InteriorDesignStatus.inProgress);
      expect(InteriorDesignStatus.fromJson(null), isNull);
    });

    test('progressRatio and progressPercentage calculate accurately', () {
      expect(InteriorDesignStatus.awaitingPricing.progressRatio, closeTo(1 / 7, 0.01));
      expect(InteriorDesignStatus.inProgress.progressRatio, closeTo(4 / 7, 0.01));
      expect(InteriorDesignStatus.completed.progressRatio, closeTo(1.0, 0.01));
      expect(InteriorDesignStatus.completed.progressPercentage, 100);
    });

    test('lifecycle helper getters return correct booleans', () {
      expect(InteriorDesignStatus.completed.isTerminal, isTrue);
      expect(InteriorDesignStatus.inProgress.isTerminal, isFalse);
      expect(InteriorDesignStatus.awaitingPayment.requiresAction, isTrue);
      expect(InteriorDesignStatus.inProgress.requiresAction, isFalse);
    });

    test('labels in English and Arabic are non-empty', () {
      for (final status in InteriorDesignStatus.values) {
        expect(status.displayLabel, isNotEmpty);
        expect(status.displayLabelAr, isNotEmpty);
        expect(status.chipBackground, isNotNull);
        expect(status.chipForeground, isNotNull);
      }
    });
  });

  group('InteriorDesignFilter Enum Tests', () {
    test('fromValue maps correctly and returns enum or null', () {
      expect(InteriorDesignFilter.fromValue('all'), InteriorDesignFilter.all);
      expect(InteriorDesignFilter.fromValue('active'), InteriorDesignFilter.active);
      expect(InteriorDesignFilter.fromValue('completed'), InteriorDesignFilter.completed);
      expect(InteriorDesignFilter.fromValue('ALL'), InteriorDesignFilter.all);
      expect(InteriorDesignFilter.fromValue(null), isNull);
      expect(InteriorDesignFilter.fromValue('invalid'), isNull);
    });
  });

  group('InteriorDesignResponseModel Serialization Tests', () {
    test('fromJson deserializes full JSON payload correctly', () {
      final json = {
        'id': 'int_100',
        'referenceNumber': 'INT-2024-100',
        'projectId': 'proj_100',
        'projectName': 'Luxury Penthouse',
        'projectThumbnailUrl': 'https://example.com/project.jpg',
        'title': 'Penthouse Interior Concept',
        'status': 4, // inProgress
        'scope': 1, // all
        'budgetTier': 3, // ultraLuxury
        'timeline': 2, // threeToSixMonths
        'specificRooms': ['Living Room', 'Master Bed'],
        'customScopeNotes': 'High ceilings with cove lighting',
        'spacePlanningRequired': true,
        'moodboards': ['Modern Elegance'],
        'colorPalette': ['Warm White', 'Sand Gold'],
        'atmosphereTags': ['Airy', 'Serene'],
        'extraNotes': 'Client requested acoustic wall panels',
        'thumbnailUrl': 'https://example.com/thumb.jpg',
        'amountDue': 55000.50,
        'designer': {
          'id': 'eng_1',
          'name': 'Arch. Noura',
          'specialization': 'Interior Architect',
          'avatarUrl': 'https://example.com/noura.jpg',
        },
        'createdAt': '2024-03-01T10:00:00.000Z',
        'updatedAt': '2024-03-05T12:00:00.000Z',
      };

      final model = InteriorDesignResponseModel.fromJson(json);

      expect(model.id, 'int_100');
      expect(model.referenceNumber, 'INT-2024-100');
      expect(model.projectId, 'proj_100');
      expect(model.projectName, 'Luxury Penthouse');
      expect(model.status, InteriorDesignStatus.inProgress);
      expect(model.scope, InteriorDesignScope.all);
      expect(model.budgetTier, BudgetTier.ultraLuxury);
      expect(model.timeline, ProjectTimeline.threeToSixMonths);
      expect(model.specificRooms, ['Living Room', 'Master Bed']);
      expect(model.spacePlanningRequired, isTrue);
      expect(model.amountDue, 55000.50);
      expect(model.designer, isNotNull);
      expect(model.designer?.name, 'Arch. Noura');
      expect(model.createdAt, isNotNull);
    });

    test('toJson serializes status to integer ID', () {
      const model = InteriorDesignResponseModel(
        id: 'int_200',
        referenceNumber: 'INT-2024-200',
        status: InteriorDesignStatus.conceptReady, // ID = 5
        amountDue: 32000.0,
      );

      final json = model.toJson();

      expect(json['id'], 'int_200');
      expect(json['reference_number'], 'INT-2024-200');
      expect(json['status'], 5);
      expect(json['amount_due'], 32000.0);
    });

    test('copyWith updates properties while retaining others', () {
      const original = InteriorDesignResponseModel(
        id: 'int_300',
        referenceNumber: 'INT-2024-300',
        status: InteriorDesignStatus.awaitingPricing,
        amountDue: 0.0,
      );

      final updated = original.copyWith(
        status: InteriorDesignStatus.awaitingPayment,
        amountDue: 25000.0,
      );

      expect(updated.id, 'int_300');
      expect(updated.referenceNumber, 'INT-2024-300');
      expect(updated.status, InteriorDesignStatus.awaitingPayment);
      expect(updated.amountDue, 25000.0);
    });

    test('props equality compares all key fields', () {
      const a = InteriorDesignResponseModel(
        id: 'int_400',
        referenceNumber: 'INT-2024-400',
        status: InteriorDesignStatus.completed,
      );
      const b = InteriorDesignResponseModel(
        id: 'int_400',
        referenceNumber: 'INT-2024-400',
        status: InteriorDesignStatus.completed,
      );
      const c = InteriorDesignResponseModel(
        id: 'int_401',
        referenceNumber: 'INT-2024-401',
        status: InteriorDesignStatus.completed,
      );

      expect(a, equals(b));
      expect(a == c, isFalse);
    });
  });

  group('ProjectResponseModel InteriorDesign Linking Tests', () {
    test('fromJson parses interiorDesignId field', () {
      final json = {
        'id': 'proj_999',
        'name': 'Villa Riviera',
        'interiorDesignId': 'int_001',
      };

      final project = ProjectResponseModel.fromJson(json);

      expect(project.id, 'proj_999');
      expect(project.interiorDesignId, 'int_001');
    });

    test('toJson serializes interiorDesignId field', () {
      const project = ProjectResponseModel(
        id: 'proj_999',
        name: 'Villa Riviera',
        interiorDesignId: 'int_001',
      );

      final json = project.toJson();

      expect(json['interior_design_id'], 'int_001');
    });

    test('copyWith modifies interiorDesignId', () {
      const project = ProjectResponseModel(
        id: 'proj_999',
        name: 'Villa Riviera',
      );

      final linked = project.copyWith(interiorDesignId: 'int_999');

      expect(linked.interiorDesignId, 'int_999');
    });
  });

  group('InteriorDesignListCubit Tests', () {
    test('initial state has default status and filter all', () {
      final repo = TestInteriorDesignRepo();
      final cubit = InteriorDesignListCubit(interiorDesignRepo: repo);

      expect(cubit.state.cubitStatus, CubitStatus.initial);
      expect(cubit.state.filter, InteriorDesignFilter.all);
      expect(cubit.state.items, isNull);
      expect(cubit.state.filteredItems, isEmpty);
    });

    test('fetchInteriorDesigns emits loading then success with items', () async {
      final repo = TestInteriorDesignRepo();
      final cubit = InteriorDesignListCubit(interiorDesignRepo: repo);

      final states = <InteriorDesignListState>[];
      cubit.stream.listen(states.add);

      await cubit.fetchInteriorDesigns();
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0].cubitStatus, CubitStatus.loading);
      expect(states[1].cubitStatus, CubitStatus.success);
      expect(states[1].items?.length, 2);
    });

    test('fetchInteriorDesigns emits error when repo fails', () async {
      final repo = TestInteriorDesignRepo(shouldFail: true);
      final cubit = InteriorDesignListCubit(interiorDesignRepo: repo);

      final states = <InteriorDesignListState>[];
      cubit.stream.listen(states.add);

      await cubit.fetchInteriorDesigns();
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0].cubitStatus, CubitStatus.loading);
      expect(states[1].cubitStatus, CubitStatus.error);
      expect(states[1].appErrorModel?.code, ErrorCodesEnum.network);
    });

    test('setFilter filters items between active and completed', () async {
      final repo = TestInteriorDesignRepo();
      final cubit = InteriorDesignListCubit(interiorDesignRepo: repo);

      await cubit.fetchInteriorDesigns();
      expect(cubit.state.filteredItems.length, 2);

      cubit.setFilter(InteriorDesignFilter.active);
      expect(cubit.state.filteredItems.length, 1);
      expect(cubit.state.filteredItems.first.status, InteriorDesignStatus.inProgress);

      cubit.setFilter(InteriorDesignFilter.completed);
      expect(cubit.state.filteredItems.length, 1);
      expect(cubit.state.filteredItems.first.status, InteriorDesignStatus.completed);

      cubit.setFilter(InteriorDesignFilter.all);
      expect(cubit.state.filteredItems.length, 2);
    });
  });

  group('InteriorDesignDetailCubit Tests', () {
    test('initial state has default status and null item', () {
      final repo = TestInteriorDesignRepo();
      final cubit = InteriorDesignDetailCubit(interiorDesignRepo: repo);

      expect(cubit.state.cubitStatus, CubitStatus.initial);
      expect(cubit.state.item, isNull);
    });

    test('fetchInteriorDesign with initialData populates immediately', () async {
      final repo = TestInteriorDesignRepo();
      final cubit = InteriorDesignDetailCubit(interiorDesignRepo: repo);

      const preview = InteriorDesignResponseModel(
        id: 'int_preview',
        title: 'Preview Concept',
        status: InteriorDesignStatus.inProgress,
      );

      final states = <InteriorDesignDetailState>[];
      cubit.stream.listen(states.add);

      await cubit.fetchInteriorDesign(id: 'int_preview', initialData: preview);
      await pumpEventQueue();

      expect(states.first.cubitStatus, CubitStatus.success);
      expect(states.first.item?.id, 'int_preview');
    });

    test('fetchInteriorDesign by ID emits loading then success', () async {
      final repo = TestInteriorDesignRepo();
      final cubit = InteriorDesignDetailCubit(interiorDesignRepo: repo);

      final states = <InteriorDesignDetailState>[];
      cubit.stream.listen(states.add);

      await cubit.fetchInteriorDesign(id: 'int_001');
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0].cubitStatus, CubitStatus.loading);
      expect(states[1].cubitStatus, CubitStatus.success);
      expect(states[1].item?.id, 'int_001');
      expect(states[1].item?.title, 'Interior Design - Villa Al-Nakheel');
    });

    test('fetchInteriorDesign emits error when repo fails and no item exists', () async {
      final repo = TestInteriorDesignRepo(shouldFail: true);
      final cubit = InteriorDesignDetailCubit(interiorDesignRepo: repo);

      final states = <InteriorDesignDetailState>[];
      cubit.stream.listen(states.add);

      await cubit.fetchInteriorDesign(id: 'non_existent');
      await pumpEventQueue();

      expect(states.length, 2);
      expect(states[0].cubitStatus, CubitStatus.loading);
      expect(states[1].cubitStatus, CubitStatus.error);
      expect(states[1].appErrorModel?.code, ErrorCodesEnum.notFound);
    });
  });
}
