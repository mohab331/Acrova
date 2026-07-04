import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignCubit extends Cubit<InteriorDesignState> {
  InteriorDesignCubit({
    required this.projectRepo,
    required String projectId,
  }) : super(InteriorDesignState(projectId: projectId));

  final BaseProjectRepo projectRepo;

  void updateScope(String scope) {
    emit(state.copyWith(scope: scope));
  }

  void toggleSpecificRoom(String room) {
    final rooms = List<String>.from(state.specificRooms);
    if (rooms.contains(room)) {
      rooms.remove(room);
    } else {
      rooms.add(room);
    }
    emit(state.copyWith(specificRooms: rooms));
  }

  void updateCustomScopeNotes(String notes) {
    emit(state.copyWith(customScopeNotes: notes));
  }

  void toggleSpacePlanning(bool value) {
    emit(state.copyWith(spacePlanningRequired: value));
  }

  void toggleMoodboard(String moodboard) {
    final list = List<String>.from(state.moodboards);
    if (list.contains(moodboard)) {
      list.remove(moodboard);
    } else {
      list.add(moodboard);
    }
    emit(state.copyWith(moodboards: list));
  }

  void toggleColor(String color) {
    final list = List<String>.from(state.colorPalette);
    if (list.contains(color)) {
      list.remove(color);
    } else {
      list.add(color);
    }
    emit(state.copyWith(colorPalette: list));
  }

  void toggleAtmosphereTag(String tag) {
    final list = List<String>.from(state.atmosphereTags);
    if (list.contains(tag)) {
      list.remove(tag);
    } else {
      list.add(tag);
    }
    emit(state.copyWith(atmosphereTags: list));
  }

  void updateBudgetTier(String tier) {
    emit(state.copyWith(budgetTier: tier));
  }

  void updateTimeline(String timeline) {
    emit(state.copyWith(timeline: timeline));
  }

  void updateExtraNotes(String notes) {
    emit(state.copyWith(extraNotes: notes));
  }

  void addInspirationMedia(String path) {
    emit(state.copyWith(
      inspirationMediaPaths: [...state.inspirationMediaPaths, path],
    ));
  }

  void removeInspirationMedia(int index) {
    final list = List<String>.from(state.inspirationMediaPaths);
    list.removeAt(index);
    emit(state.copyWith(inspirationMediaPaths: list));
  }

  void addInspirationLink(String link) {
    emit(state.copyWith(
      inspirationLinks: [...state.inspirationLinks, link],
    ));
  }

  void removeInspirationLink(int index) {
    final list = List<String>.from(state.inspirationLinks);
    list.removeAt(index);
    emit(state.copyWith(inspirationLinks: list));
  }

  Future<void> submit() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: InteriorDesignStatus.loading));
    try {
      state.toRequest();
      // final result = await projectRepo.submitInteriorDesign(request);
      
      // Mocking submission for now
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: InteriorDesignStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: InteriorDesignStatus.failure,
        error: AppErrorModel.fromException(e),
      ));
    }
  }
}
