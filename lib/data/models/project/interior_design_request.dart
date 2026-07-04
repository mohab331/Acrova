class InteriorDesignRequest {
  final String projectId;
  final String scope; // 'all' or 'specific'
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

  const InteriorDesignRequest({
    required this.projectId,
    required this.scope,
    this.specificRooms = const [],
    this.customScopeNotes = '',
    this.spacePlanningRequired = false,
    this.moodboards = const [],
    this.colorPalette = const [],
    this.atmosphereTags = const [],
    required this.budgetTier,
    required this.timeline,
    this.extraNotes = '',
    this.inspirationMediaPaths = const [],
    this.inspirationLinks = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'scope': scope,
      'specificRooms': specificRooms,
      'customScopeNotes': customScopeNotes,
      'spacePlanningRequired': spacePlanningRequired,
      'moodboards': moodboards,
      'colorPalette': colorPalette,
      'atmosphereTags': atmosphereTags,
      'budgetTier': budgetTier,
      'timeline': timeline,
      'extraNotes': extraNotes,
      'inspirationMediaPaths': inspirationMediaPaths,
      'inspirationLinks': inspirationLinks,
    };
  }

  factory InteriorDesignRequest.fromJson(Map<String, dynamic> json) {
    return InteriorDesignRequest(
      projectId: json['projectId'] as String? ?? '',
      scope: json['scope'] as String? ?? 'all',
      specificRooms: (json['specificRooms'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      customScopeNotes: json['customScopeNotes'] as String? ?? '',
      spacePlanningRequired: json['spacePlanningRequired'] as bool? ?? false,
      moodboards: (json['moodboards'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      colorPalette: (json['colorPalette'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      atmosphereTags: (json['atmosphereTags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      budgetTier: json['budgetTier'] as String? ?? '',
      timeline: json['timeline'] as String? ?? '',
      extraNotes: json['extraNotes'] as String? ?? '',
      inspirationMediaPaths: (json['inspirationMediaPaths'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      inspirationLinks: (json['inspirationLinks'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }

  InteriorDesignRequest copyWith({
    String? projectId,
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
  }) {
    return InteriorDesignRequest(
      projectId: projectId ?? this.projectId,
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
    );
  }
}
