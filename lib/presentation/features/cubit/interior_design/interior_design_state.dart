import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/project/interior_design_request.dart';
import 'package:equatable/equatable.dart';

enum InteriorDesignStatus { initial, loading, success, failure }

class InteriorDesignState extends Equatable {
  final String projectId;
  final String scope;
  final List<String> specificRooms;
  final String customScopeNotes;
  final bool spacePlanningRequired;
  final List<String> moodboards;
  final List<String> colorPalette;
  final List<String> atmosphereTags;
  final String budgetTier;
  final String timeline;
  final String extraNotes;
  final List<String> inspirationMediaPaths;
  final List<String> inspirationLinks;
  
  final InteriorDesignStatus status;
  final AppErrorModel? error;

  const InteriorDesignState({
    required this.projectId,
    this.scope = 'all',
    this.specificRooms = const [],
    this.customScopeNotes = '',
    this.spacePlanningRequired = false,
    this.moodboards = const [],
    this.colorPalette = const [],
    this.atmosphereTags = const [],
    this.budgetTier = '',
    this.timeline = '',
    this.extraNotes = '',
    this.inspirationMediaPaths = const [],
    this.inspirationLinks = const [],
    this.status = InteriorDesignStatus.initial,
    this.error,
  });

  bool get isValid {
    if (scope == 'specific' && specificRooms.isEmpty && customScopeNotes.isEmpty) {
      return false;
    }
    if (budgetTier.isEmpty || timeline.isEmpty) return false;
    return true;
  }

  InteriorDesignRequest toRequest() {
    return InteriorDesignRequest(
      projectId: projectId,
      scope: scope,
      specificRooms: specificRooms,
      customScopeNotes: customScopeNotes,
      spacePlanningRequired: spacePlanningRequired,
      moodboards: moodboards,
      colorPalette: colorPalette,
      atmosphereTags: atmosphereTags,
      budgetTier: budgetTier,
      timeline: timeline,
      extraNotes: extraNotes,
      inspirationMediaPaths: inspirationMediaPaths,
      inspirationLinks: inspirationLinks,
    );
  }

  InteriorDesignState copyWith({
    String? scope,
    List<String>? specificRooms,
    String? customScopeNotes,
    bool? spacePlanningRequired,
    List<String>? moodboards,
    List<String>? colorPalette,
    List<String>? atmosphereTags,
    String? budgetTier,
    String? timeline,
    String? extraNotes,
    List<String>? inspirationMediaPaths,
    List<String>? inspirationLinks,
    InteriorDesignStatus? status,
    AppErrorModel? error,
  }) {
    return InteriorDesignState(
      projectId: projectId,
      scope: scope ?? this.scope,
      specificRooms: specificRooms ?? this.specificRooms,
      customScopeNotes: customScopeNotes ?? this.customScopeNotes,
      spacePlanningRequired: spacePlanningRequired ?? this.spacePlanningRequired,
      moodboards: moodboards ?? this.moodboards,
      colorPalette: colorPalette ?? this.colorPalette,
      atmosphereTags: atmosphereTags ?? this.atmosphereTags,
      budgetTier: budgetTier ?? this.budgetTier,
      timeline: timeline ?? this.timeline,
      extraNotes: extraNotes ?? this.extraNotes,
      inspirationMediaPaths: inspirationMediaPaths ?? this.inspirationMediaPaths,
      inspirationLinks: inspirationLinks ?? this.inspirationLinks,
      status: status ?? this.status,
      error: error ?? this.error,
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
        status,
        error,
      ];
}
