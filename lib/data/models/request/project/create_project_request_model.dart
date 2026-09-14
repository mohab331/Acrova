import 'package:acrova/utils/enums/design_style_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/enums/smart_home_level_enum.dart';

import '../base_request_model.dart';

/// All data collected across the 6-step project creation wizard.
class CreateProjectRequestModel extends BaseRequestModel {
  const CreateProjectRequestModel({
    // Step 1
    required this.projectType,
    // Step 2
    required this.location,
    required this.landAreaSqm,
    required this.landWidthM,
    required this.landLengthM,
    required this.floors,
    this.employeeCount = 0, // For commercial
    // Step 3
    required this.bedrooms,
    required this.bathrooms,
    this.hasMajlis = false,
    this.hasMaidRoom = false,
    this.hasDriverRoom = false,
    this.hasBasement = false,
    this.hasPool = false,
    this.hasRooftop = false,
    this.smartHomeLevel = SmartHomeLevel.basic,
    // Step 4
    required this.architecturalStyle,
    this.additionalNotes = '',
    // Step 5
    this.mediaPaths = const [],
  });

  // ── Step 1: Project type ───────────────────────────────────────────────────
  final ProjectType projectType;

  // ── Step 2: Land details & Scope ───────────────────────────────────────────
  final String location;
  final double landAreaSqm;
  final double landWidthM;
  final double landLengthM;
  final int floors;
  final int employeeCount;

  // ── Step 3: Building requirements ─────────────────────────────────────────
  final int bedrooms;
  final int bathrooms;
  final bool hasMajlis;
  final bool hasMaidRoom;
  final bool hasDriverRoom;
  final bool hasBasement;
  final bool hasPool;
  final bool hasRooftop;
  final SmartHomeLevel smartHomeLevel;

  // ── Step 4: Design preferences ────────────────────────────────────────────
  final DesignStyle? architecturalStyle;
  final String additionalNotes;

  // ── Step 5: Media uploads ─────────────────────────────────────────────────
  final List<String> mediaPaths;

  // ── SBC pre-check (client-side advisory only) ─────────────────────────────
  bool get sbcAreaWarning => landAreaSqm < 150;
  bool get sbcFloorWarning => floors > 5;
  bool get sbcWidthAdvisory => landWidthM < 10;
  bool get hasSbcWarnings =>
      sbcAreaWarning || sbcFloorWarning || sbcWidthAdvisory;

  @override
  Map<String, dynamic> toJson() => {
    'project_type': projectType.jsonKey,
    'location': location,
    'land_area_sqm': landAreaSqm,
    'land_width_m': landWidthM,
    'land_length_m': landLengthM,
    'floors': floors,
    'employee_count': employeeCount,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'has_majlis': hasMajlis,
    'has_maid_room': hasMaidRoom,
    'has_driver_room': hasDriverRoom,
    'has_basement': hasBasement,
    'has_pool': hasPool,
    'has_rooftop': hasRooftop,
    'smart_home_level': smartHomeLevel,
    'architectural_style': architecturalStyle,
    'additional_notes': additionalNotes,
    'media_count': mediaPaths.length,
  };

  @override
  List<Object?> get props => [
    projectType,
    location,
    landAreaSqm,
    landWidthM,
    landLengthM,
    floors,
    employeeCount,
    bedrooms,
    bathrooms,
    hasMajlis,
    hasMaidRoom,
    hasDriverRoom,
    hasBasement,
    hasPool,
    hasRooftop,
    smartHomeLevel,
    architecturalStyle,
    additionalNotes,
    mediaPaths,
  ];

  CreateProjectRequestModel copyWith({
    ProjectType? projectType,
    String? location,
    double? landAreaSqm,
    double? landWidthM,
    double? landLengthM,
    int? floors,
    int? employeeCount,
    int? bedrooms,
    int? bathrooms,
    bool? hasMajlis,
    bool? hasMaidRoom,
    bool? hasDriverRoom,
    bool? hasBasement,
    bool? hasPool,
    bool? hasRooftop,
    SmartHomeLevel? smartHomeLevel,
    DesignStyle? architecturalStyle,
    String? additionalNotes,
    List<String>? mediaPaths,
  }) {
    return CreateProjectRequestModel(
      projectType: projectType ?? this.projectType,
      location: location ?? this.location,
      landAreaSqm: landAreaSqm ?? this.landAreaSqm,
      landWidthM: landWidthM ?? this.landWidthM,
      landLengthM: landLengthM ?? this.landLengthM,
      floors: floors ?? this.floors,
      employeeCount: employeeCount ?? this.employeeCount,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      hasMajlis: hasMajlis ?? this.hasMajlis,
      hasMaidRoom: hasMaidRoom ?? this.hasMaidRoom,
      hasDriverRoom: hasDriverRoom ?? this.hasDriverRoom,
      hasBasement: hasBasement ?? this.hasBasement,
      hasPool: hasPool ?? this.hasPool,
      hasRooftop: hasRooftop ?? this.hasRooftop,
      smartHomeLevel: smartHomeLevel ?? this.smartHomeLevel,
      architecturalStyle: architecturalStyle ?? this.architecturalStyle,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      mediaPaths: mediaPaths ?? this.mediaPaths,
    );
  }

  @override
  String toString() {
    return 'CreateProjectRequestModel('
        'projectType: $projectType, '
        'location: $location, '
        'landAreaSqm: $landAreaSqm'
        ')';
  }
}
