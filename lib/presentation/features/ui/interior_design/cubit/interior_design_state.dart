import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/interior_design/moodboard_model.dart';
import 'package:acrova/data/models/project/interior_design_request.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/interior_design_enums.dart';
import 'package:equatable/equatable.dart';

class InteriorDesignState extends Equatable {
  final InteriorDesignScope scope;
  final List<String> specificRooms;
  final String customScopeNotes;
  final bool spacePlanningRequired;
  final List<String> moodboards;
  final List<String> colorPalette;
  final List<String> atmosphereTags;
  final BudgetTier? budgetTier;
  final ProjectTimeline? timeline;
  final String extraNotes;
  final List<String> inspirationMediaPaths;
  final List<String> inspirationLinks;
  final List<MoodboardModel> availableMoodboards;

  final CubitStatus status;
  final AppErrorModel? error;

  const InteriorDesignState({
    this.scope = InteriorDesignScope.all,
    this.specificRooms = const [],
    this.customScopeNotes = '',
    this.spacePlanningRequired = false,
    this.moodboards = const [],
    this.colorPalette = const [],
    this.atmosphereTags = const [],
    this.budgetTier,
    this.timeline,
    this.extraNotes = '',
    this.inspirationMediaPaths = const [],
    this.inspirationLinks = const [],
    this.availableMoodboards = const [],
    this.status = CubitStatus.initial,
    this.error,
  });

  bool get isLoading => status == CubitStatus.loading;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;

  bool get isValid {
    if (scope == InteriorDesignScope.specific &&
        specificRooms.isEmpty &&
        customScopeNotes.isEmpty) {
      return false;
    }
    if (budgetTier == null || timeline == null) return false;
    return true;
  }

  String get scopeString => scope.value;
  String get budgetTierString => budgetTier?.value ?? '';
  String get timelineString => timeline?.value ?? '';

  InteriorDesignRequest toRequest({required String projectId}) {
    return InteriorDesignRequest(
      projectId: projectId,
      scope: scope.value,
      specificRooms: specificRooms,
      customScopeNotes: customScopeNotes,
      spacePlanningRequired: spacePlanningRequired,
      moodboards: moodboards,
      colorPalette: colorPalette,
      atmosphereTags: atmosphereTags,
      budgetTier: budgetTier?.value ?? '',
      timeline: timeline?.value ?? '',
      extraNotes: extraNotes,
      inspirationMediaPaths: inspirationMediaPaths,
      inspirationLinks: inspirationLinks,
    );
  }

  InteriorDesignState copyWith({
    InteriorDesignScope? scope,
    List<String>? specificRooms,
    String? customScopeNotes,
    bool? spacePlanningRequired,
    List<String>? moodboards,
    List<String>? colorPalette,
    List<String>? atmosphereTags,
    BudgetTier? budgetTier,
    ProjectTimeline? timeline,
    String? extraNotes,
    List<String>? inspirationMediaPaths,
    List<String>? inspirationLinks,
    List<MoodboardModel>? availableMoodboards,
    CubitStatus? status,
    AppErrorModel? error,
  }) {
    return InteriorDesignState(
      scope: scope ?? this.scope,
      specificRooms: specificRooms ?? this.specificRooms,
      customScopeNotes: customScopeNotes ?? this.customScopeNotes,
      spacePlanningRequired:
          spacePlanningRequired ?? this.spacePlanningRequired,
      moodboards: moodboards ?? this.moodboards,
      colorPalette: colorPalette ?? this.colorPalette,
      atmosphereTags: atmosphereTags ?? this.atmosphereTags,
      budgetTier: budgetTier ?? this.budgetTier,
      timeline: timeline ?? this.timeline,
      extraNotes: extraNotes ?? this.extraNotes,
      inspirationMediaPaths:
          inspirationMediaPaths ?? this.inspirationMediaPaths,
      inspirationLinks: inspirationLinks ?? this.inspirationLinks,
      availableMoodboards: availableMoodboards ?? this.availableMoodboards,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    scope,
    specificRooms,
    customScopeNotes,
    spacePlanningRequired,
    moodboards,
    colorPalette,
    atmosphereTags,
    budgetTier,
    timeline,
    extraNotes,
    inspirationMediaPaths,
    inspirationLinks,
    availableMoodboards,
    status,
    error,
  ];
}
