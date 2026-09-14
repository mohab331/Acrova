import 'package:acrova/utils/enums/budget_tier_enum.dart';
import 'package:acrova/utils/enums/interior_design_scope_enum.dart';
import 'package:acrova/utils/enums/project_timeline_enum.dart';

import '../base_request_model.dart';

export 'package:acrova/utils/enums/budget_tier_enum.dart';
export 'package:acrova/utils/enums/interior_design_scope_enum.dart';
export 'package:acrova/utils/enums/project_timeline_enum.dart';

class InteriorDesignRequestModel extends BaseRequestModel {
  final String projectId;
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

  const InteriorDesignRequestModel({
    required this.projectId,
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
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'scope_id': scope.id,
      'scope': scope.id,
      'specificRooms': specificRooms,
      'customScopeNotes': customScopeNotes,
      'spacePlanningRequired': spacePlanningRequired,
      'moodboards': moodboards,
      'colorPalette': colorPalette,
      'atmosphereTags': atmosphereTags,
      'budget_tier_id': budgetTier?.id,
      'budget_tier': budgetTier?.id,
      'timeline_id': timeline?.id,
      'timeline': timeline?.id,
      'extraNotes': extraNotes,
      'inspirationMediaPaths': inspirationMediaPaths,
      'inspirationLinks': inspirationLinks,
    };
  }

  factory InteriorDesignRequestModel.fromJson(Map<String, dynamic> json) {
    return InteriorDesignRequestModel(
      projectId: json['projectId'] as String? ?? '',
      scope:
          InteriorDesignScope.fromValue(json['scope_id']) ??
          InteriorDesignScope.all,
      specificRooms:
          (json['specificRooms'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      customScopeNotes: json['customScopeNotes'] as String? ?? '',
      spacePlanningRequired: json['spacePlanningRequired'] as bool? ?? false,
      moodboards:
          (json['moodboards'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      colorPalette:
          (json['colorPalette'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      atmosphereTags:
          (json['atmosphereTags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      budgetTier: BudgetTier.fromValue(json['budget_tier']),
      timeline: ProjectTimeline.fromValue(json['timeline_id']),
      extraNotes: json['extraNotes'] as String? ?? '',
      inspirationMediaPaths:
          (json['inspirationMediaPaths'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      inspirationLinks:
          (json['inspirationLinks'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }



  InteriorDesignRequestModel copyWith({
    String? projectId,
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
  }) {
    return InteriorDesignRequestModel(
      projectId: projectId ?? this.projectId,
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
    );
  }

  @override
  List<Object?> get props => [
    projectId,
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
  ];

  @override
  String toString() {
    return 'InteriorDesignRequestModel('
        'projectId: $projectId, '
        'scope: $scope, '
        'budgetTier: $budgetTier, '
        'timeline: $timeline'
        ')';
  }
}
