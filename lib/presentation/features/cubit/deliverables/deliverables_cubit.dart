import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/enums/cubit_status.dart';

class DeliverablesCubit extends Cubit<DeliverablesState> {
  DeliverablesCubit() : super(const DeliverablesState());

  Future<void> fetchDeliverables() async {
    emit(state.copyWith(status: CubitStatus.loading));

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    final mockBlueprints = [
      const BlueprintModel(
        title: 'Floor Plan v1.1',
        size: '2.4MB',
        format: 'PDF',
        urlOrAsset: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      const BlueprintModel(
        title: 'Electrical Layout',
        size: '4.1MB',
        format: 'PDF',
        urlOrAsset: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      const BlueprintModel(
        title: 'Plumbing & HVAC',
        size: '3.8MB',
        format: 'PDF',
        urlOrAsset: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
    ];

    final mockRenders = [
      RenderModel(
        resolution: '4K',
        imageAsset: Resources.drawables.img1,
      ),
      RenderModel(
        resolution: '4K',
        imageAsset: Resources.drawables.img2,
      ),
      RenderModel(
        resolution: '4K',
        imageAsset: Resources.drawables.img1,
      ),
    ];

    final mockWalkthroughs = [
      WalkthroughModel(
        title: 'Interior Narrative Tour',
        duration: '02:45',
        size: '89MB',
        format: 'MP4',
        imageAsset: Resources.drawables.img2,
      ),
      WalkthroughModel(
        title: 'Exterior Drone Footage',
        duration: '01:20',
        size: '45MB',
        format: 'MP4',
        imageAsset: Resources.drawables.img1,
      ),
    ];

    emit(
      state.copyWith(
        status: CubitStatus.success,
        blueprints: mockBlueprints,
        renders: mockRenders,
        walkthroughs: mockWalkthroughs,
      ),
    );
  }
}
