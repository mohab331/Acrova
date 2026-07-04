import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:bloc/bloc.dart';

import 'project_creation_state.dart';

class ProjectCreationCubit extends Cubit<ProjectCreationState> {
  ProjectCreationCubit({required BaseProjectRepo projectRepo})
      : _projectRepo = projectRepo,
        super(const ProjectCreationState());

  final BaseProjectRepo _projectRepo;

  // ── Navigation ───────────────────────────────────────────────────────────

  void nextStep() {
    if (state.currentStep < kWizardStepCount - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void prevStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void goToStep(int step) {
    assert(step >= 0 && step < kWizardStepCount);
    emit(state.copyWith(currentStep: step));
  }

  // ── Step 1: Project type ─────────────────────────────────────────────────

  void selectProjectType(ProjectType type) =>
      emit(state.copyWith(selectedType: type));

  // ── Step 2: Land details ─────────────────────────────────────────────────

  void updateLocation(String value) => emit(state.copyWith(location: value));

  void updateLandArea(double? value) => emit(state.copyWith(landAreaSqm: value));

  void updateLandWidth(double? value) => emit(state.copyWith(landWidthM: value));

  void updateLandLength(double? value) => emit(state.copyWith(landLengthM: value));

  void updateFloors(int value) =>
      emit(state.copyWith(floors: value.clamp(1, 10)));
      
  void updateEmployeeCount(int value) =>
      emit(state.copyWith(employeeCount: value.clamp(0, 10000)));

  // ── Step 3: Building requirements ────────────────────────────────────────

  void updateBedrooms(int value) =>
      emit(state.copyWith(bedrooms: value.clamp(1, 20)));

  void updateBathrooms(int value) =>
      emit(state.copyWith(bathrooms: value.clamp(1, 20)));

  void toggleMajlis(bool value) => emit(state.copyWith(hasMajlis: value));
  void toggleMaidRoom(bool value) => emit(state.copyWith(hasMaidRoom: value));
  void toggleDriverRoom(bool value) => emit(state.copyWith(hasDriverRoom: value));
  void toggleBasement(bool value) => emit(state.copyWith(hasBasement: value));
  void togglePool(bool value) => emit(state.copyWith(hasPool: value));
  void toggleRooftop(bool value) => emit(state.copyWith(hasRooftop: value));
  
  void updateSmartHomeLevel(String level) => emit(state.copyWith(smartHomeLevel: level));

  // ── Step 4: Design preferences ────────────────────────────────────────────

  void selectStyle(String style) => emit(state.copyWith(architecturalStyle: style));

  void updateNotes(String value) => emit(state.copyWith(additionalNotes: value));

  // ── Step 5: Media ─────────────────────────────────────────────────────────

  void addMedia(String path) =>
      emit(state.copyWith(mediaPaths: [...state.mediaPaths, path]));

  void removeMedia(String path) =>
      emit(state.copyWith(
        mediaPaths: state.mediaPaths.where((p) => p != path).toList(),
      ));

  // ── Step 6: Submit ────────────────────────────────────────────────────────

  Future<void> submit() async {
    if (!state.step6Valid) return;

    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final result = await _projectRepo.createProject(state.toRequest());
    result.when(
      success: (project) {
        emit(state.copyWith(
          cubitStatus: CubitStatus.success,
          createdProject: project,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          cubitStatus: CubitStatus.error,
          appErrorModel: error,
        ));
      },
    );
  }

  void resetError() => emit(state.copyWith(cubitStatus: CubitStatus.initial));
}
