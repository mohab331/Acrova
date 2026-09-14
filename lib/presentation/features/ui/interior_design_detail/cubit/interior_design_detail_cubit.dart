import 'package:acrova/data/models/request/interior_design/get_interior_design_request_model.dart';
import 'package:acrova/domain/repository/interior_design/base_interior_design_repo.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/cubit/interior_design_detail_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignDetailCubit extends Cubit<InteriorDesignDetailState> {
  InteriorDesignDetailCubit({
    required BaseInteriorDesignRepo interiorDesignRepo,
  }) : _interiorDesignRepo = interiorDesignRepo,
       super(const InteriorDesignDetailState());

  final BaseInteriorDesignRepo _interiorDesignRepo;

  Future<void> fetchInteriorDesign({String? id}) async {
    final targetId = id ?? state.id;
    if (targetId == null || targetId.isEmpty) return;

    emit(state.copyWith(cubitStatus: CubitStatus.loading, id: targetId));

    final result = await _interiorDesignRepo.getInteriorDesign(
      GetInteriorDesignRequestModel(id: targetId),
    );

    result.when(
      success: (data) {
        emit(state.copyWith(cubitStatus: CubitStatus.success, item: data));
      },
      failure: (error) {
        if (state.item == null) {
          emit(
            state.copyWith(
              cubitStatus: CubitStatus.error,
              appErrorModel: error,
            ),
          );
        }
      },
    );
  }
}
