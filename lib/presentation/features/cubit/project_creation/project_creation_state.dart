import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:equatable/equatable.dart';

/// Total number of wizard steps (1-indexed labels, 0-indexed internally).
const int kWizardStepCount = 6;

class ProjectCreationState extends Equatable {
  const ProjectCreationState({
    this.currentStep = 0,
    this.cubitStatus = CubitStatus.initial,
    this.createdProject,
    this.appErrorModel,
    // Step 1
    this.selectedType,
    // Step 2
    this.location = '',
    this.landAreaSqm,
    this.landWidthM,
    this.landLengthM,
    this.floors = 1,
    // Step 3
    this.bedrooms = 3,
    this.bathrooms = 2,
    this.hasMajlis = false,
    this.hasMaidRoom = false,
    this.hasDriverRoom = false,
    this.hasBasement = false,
    this.hasPool = false,
    this.hasRooftop = false,
    // Step 4
    this.stylePreference = '',
    this.additionalNotes = '',
    // Step 5
    this.mediaPaths = const [],
  });

  final int currentStep;
  final CubitStatus cubitStatus;
  final ProjectModel? createdProject;
  final AppErrorModel? appErrorModel;

  // Step 1
  final ProjectType? selectedType;

  // Step 2
  final String location;
  final double? landAreaSqm;
  final double? landWidthM;
  final double? landLengthM;
  final int floors;

  // Step 3
  final int bedrooms;
  final int bathrooms;
  final bool hasMajlis;
  final bool hasMaidRoom;
  final bool hasDriverRoom;
  final bool hasBasement;
  final bool hasPool;
  final bool hasRooftop;

  // Step 4
  final String stylePreference;
  final String additionalNotes;

  // Step 5
  final List<String> mediaPaths;

  bool get isSubmitting => cubitStatus == CubitStatus.loading;
  bool get isSubmitSuccess => cubitStatus == CubitStatus.success;
  bool get isSubmitError => cubitStatus == CubitStatus.error;

  // ── Step-level validation ────────────────────────────────────────────────

  bool get step1Valid => selectedType != null;

  bool get step2Valid =>
      location.trim().isNotEmpty &&
      landAreaSqm != null &&
      landAreaSqm! > 0 &&
      landWidthM != null &&
      landWidthM! > 0 &&
      landLengthM != null &&
      landLengthM! > 0 &&
      floors >= 1;

  bool get step3Valid => bedrooms >= 1 && bathrooms >= 1;

  bool get step4Valid => stylePreference.isNotEmpty;

  // Step 5 (media) is optional — always valid
  bool get step5Valid => true;

  // Step 6 (review) — all previous must be valid
  bool get step6Valid => step1Valid && step2Valid && step3Valid && step4Valid;

  bool get currentStepValid {
    switch (currentStep) {
      case 0:  return step1Valid;
      case 1:  return step2Valid;
      case 2:  return step3Valid;
      case 3:  return step4Valid;
      case 4:  return step5Valid;
      case 5:  return step6Valid;
      default: return false;
    }
  }

  // ── SBC warnings ────────────────────────────────────────────────────────

  bool get sbcAreaWarning => landAreaSqm != null && landAreaSqm! < 150;
  bool get sbcFloorWarning => floors > 5;
  bool get sbcWidthAdvisory => landWidthM != null && landWidthM! < 10;
  bool get hasSbcWarnings => sbcAreaWarning || sbcFloorWarning || sbcWidthAdvisory;

  /// Build the final request object from accumulated wizard data.
  CreateProjectRequest toRequest() => CreateProjectRequest(
        projectType:     selectedType!,
        location:        location.trim(),
        landAreaSqm:     landAreaSqm!,
        landWidthM:      landWidthM!,
        landLengthM:     landLengthM!,
        floors:          floors,
        bedrooms:        bedrooms,
        bathrooms:       bathrooms,
        hasMajlis:       hasMajlis,
        hasMaidRoom:     hasMaidRoom,
        hasDriverRoom:   hasDriverRoom,
        hasBasement:     hasBasement,
        hasPool:         hasPool,
        hasRooftop:      hasRooftop,
        stylePreference: stylePreference,
        additionalNotes: additionalNotes,
        mediaPaths:      mediaPaths,
      );

  ProjectCreationState copyWith({
    int? currentStep,
    CubitStatus? cubitStatus,
    ProjectModel? createdProject,
    AppErrorModel? appErrorModel,
    ProjectType? selectedType,
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
  }) =>
      ProjectCreationState(
        currentStep:     currentStep     ?? this.currentStep,
        cubitStatus:     cubitStatus     ?? this.cubitStatus,
        createdProject:  createdProject  ?? this.createdProject,
        appErrorModel:   appErrorModel   ?? this.appErrorModel,
        selectedType:    selectedType    ?? this.selectedType,
        location:        location        ?? this.location,
        landAreaSqm:     landAreaSqm     ?? this.landAreaSqm,
        landWidthM:      landWidthM      ?? this.landWidthM,
        landLengthM:     landLengthM     ?? this.landLengthM,
        floors:          floors          ?? this.floors,
        bedrooms:        bedrooms        ?? this.bedrooms,
        bathrooms:       bathrooms       ?? this.bathrooms,
        hasMajlis:       hasMajlis       ?? this.hasMajlis,
        hasMaidRoom:     hasMaidRoom     ?? this.hasMaidRoom,
        hasDriverRoom:   hasDriverRoom   ?? this.hasDriverRoom,
        hasBasement:     hasBasement     ?? this.hasBasement,
        hasPool:         hasPool         ?? this.hasPool,
        hasRooftop:      hasRooftop      ?? this.hasRooftop,
        stylePreference: stylePreference ?? this.stylePreference,
        additionalNotes: additionalNotes ?? this.additionalNotes,
        mediaPaths:      mediaPaths      ?? this.mediaPaths,
      );

  @override
  List<Object?> get props => [
        currentStep, cubitStatus, createdProject, appErrorModel,
        selectedType, location, landAreaSqm, landWidthM, landLengthM, floors,
        bedrooms, bathrooms,
        hasMajlis, hasMaidRoom, hasDriverRoom, hasBasement, hasPool, hasRooftop,
        stylePreference, additionalNotes, mediaPaths,
      ];
}
