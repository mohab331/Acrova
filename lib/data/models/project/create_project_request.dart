import 'package:acrova/utils/enums/project_type_enum.dart';

/// All data collected across the 6-step project creation wizard.
class CreateProjectRequest {
  const CreateProjectRequest({
    // Step 1
    required this.projectType,
    // Step 2
    required this.location,
    required this.landAreaSqm,
    required this.landWidthM,
    required this.landLengthM,
    required this.floors,
    // Step 3
    required this.bedrooms,
    required this.bathrooms,
    this.hasMajlis       = false,
    this.hasMaidRoom     = false,
    this.hasDriverRoom   = false,
    this.hasBasement     = false,
    this.hasPool         = false,
    this.hasRooftop      = false,
    // Step 4
    required this.stylePreference,
    this.additionalNotes = '',
    // Step 5
    this.mediaPaths      = const [],
  });

  // ── Step 1: Project type ───────────────────────────────────────────────────
  final ProjectType projectType;

  // ── Step 2: Land details ───────────────────────────────────────────────────
  final String location;
  final double landAreaSqm;
  final double landWidthM;
  final double landLengthM;
  final int floors;

  // ── Step 3: Building requirements ─────────────────────────────────────────
  final int bedrooms;
  final int bathrooms;
  final bool hasMajlis;
  final bool hasMaidRoom;
  final bool hasDriverRoom;
  final bool hasBasement;
  final bool hasPool;
  final bool hasRooftop;

  // ── Step 4: Design preferences ────────────────────────────────────────────
  final String stylePreference;   // 'modern' | 'classic' | 'contemporary'
  final String additionalNotes;

  // ── Step 5: Media uploads ─────────────────────────────────────────────────
  final List<String> mediaPaths;

  // ── SBC pre-check (client-side advisory only) ─────────────────────────────

  /// True if land area is below SBC 1101 minimum of 150 sqm (advisory).
  bool get sbcAreaWarning => landAreaSqm < 150;

  /// True if floor count exceeds SBC maximum of 5 (advisory).
  bool get sbcFloorWarning => floors > 5;

  /// True if land width is below advisory 10m threshold.
  bool get sbcWidthAdvisory => landWidthM < 10;

  bool get hasSbcWarnings =>
      sbcAreaWarning || sbcFloorWarning || sbcWidthAdvisory;

  Map<String, dynamic> toJson() => {
        'project_type':        projectType.jsonKey,
        'location':            location,
        'land_area_sqm':       landAreaSqm,
        'land_width_m':        landWidthM,
        'land_length_m':       landLengthM,
        'floors':              floors,
        'bedrooms':            bedrooms,
        'bathrooms':           bathrooms,
        'has_majlis':          hasMajlis,
        'has_maid_room':       hasMaidRoom,
        'has_driver_room':     hasDriverRoom,
        'has_basement':        hasBasement,
        'has_pool':            hasPool,
        'has_rooftop':         hasRooftop,
        'style_preference':    stylePreference,
        'additional_notes':    additionalNotes,
        'media_count':         mediaPaths.length,
      };

  CreateProjectRequest copyWith({
    ProjectType? projectType,
    String? location,
    double? landAreaSqm,
    double? landWidthM,
    double? landLengthM,
    int? floors,
    int? bedrooms,
    int? bathrooms,
    bool? hasMajlis,
    bool? hasMaidRoom,
    bool? hasDriverRoom,
    bool? hasBasement,
    bool? hasPool,
    bool? hasRooftop,
    String? stylePreference,
    String? additionalNotes,
    List<String>? mediaPaths,
  }) {
    return CreateProjectRequest(
      projectType:      projectType      ?? this.projectType,
      location:         location         ?? this.location,
      landAreaSqm:      landAreaSqm      ?? this.landAreaSqm,
      landWidthM:       landWidthM       ?? this.landWidthM,
      landLengthM:      landLengthM      ?? this.landLengthM,
      floors:           floors           ?? this.floors,
      bedrooms:         bedrooms         ?? this.bedrooms,
      bathrooms:        bathrooms        ?? this.bathrooms,
      hasMajlis:        hasMajlis        ?? this.hasMajlis,
      hasMaidRoom:      hasMaidRoom      ?? this.hasMaidRoom,
      hasDriverRoom:    hasDriverRoom    ?? this.hasDriverRoom,
      hasBasement:      hasBasement      ?? this.hasBasement,
      hasPool:          hasPool          ?? this.hasPool,
      hasRooftop:       hasRooftop       ?? this.hasRooftop,
      stylePreference:  stylePreference  ?? this.stylePreference,
      additionalNotes:  additionalNotes  ?? this.additionalNotes,
      mediaPaths:       mediaPaths       ?? this.mediaPaths,
    );
  }
}

/// Supported design style tokens.
abstract final class DesignStyle {
  static const String modern       = 'modern';
  static const String classic      = 'classic';
  static const String contemporary = 'contemporary';
  static const String minimalist   = 'minimalist';

  static const List<String> all = [modern, classic, contemporary, minimalist];

  static String label(String key) {
    switch (key) {
      case modern:       return 'Modern';
      case classic:      return 'Classic';
      case contemporary: return 'Contemporary';
      case minimalist:   return 'Minimalist';
      default:           return key;
    }
  }
}
