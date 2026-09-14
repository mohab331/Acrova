import 'package:acrova/domain/repository/interior_design/base_interior_design_repo.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/cubit/interior_design_list_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/interior_design_filter_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignListCubit extends Cubit<InteriorDesignListState> {
  InteriorDesignListCubit({required BaseInteriorDesignRepo interiorDesignRepo})
    : _interiorDesignRepo = interiorDesignRepo,
      super(const InteriorDesignListState());

  final BaseInteriorDesignRepo _interiorDesignRepo;

  Future<void> fetchInteriorDesigns() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _interiorDesignRepo.getInteriorDesigns();
    result.when(
      success: (items) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.success, items: items),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }

  void setFilter(InteriorDesignFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
