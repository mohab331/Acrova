import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_cubit.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_state.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/blueprints_section.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/deliverables_app_bar.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/deliverables_loading_skeleton.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/deliverables_sticky_actions.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/renders_section.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/walkthroughs_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/enums/cubit_status.dart';

class DeliverablesPage extends StatelessWidget {
  const DeliverablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocatorInstance<DeliverablesCubit>()..fetchDeliverables(),
      child: const _DeliverablesView(),
    );
  }
}

class _DeliverablesView extends StatelessWidget {
  const _DeliverablesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.colors.luxurySurface,
      body: BlocBuilder<DeliverablesCubit, DeliverablesState>(
        builder: (context, state) {
          if (state.status == CubitStatus.loading || state.status == CubitStatus.initial) {
            return const DeliverablesLoadingSkeleton();
          }

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: Resources.verticalDims.$100, // Account for sticky header
                      bottom: Resources.verticalDims.$200, // Account for sticky footer
                      left: Resources.horizontalDims.$24,
                      right: Resources.horizontalDims.$24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        BlueprintsSection(blueprints: state.blueprints),
                        SizedBox(height: Resources.verticalDims.$40),
                        RendersSection(renders: state.renders),
                        SizedBox(height: Resources.verticalDims.$40),
                        WalkthroughsSection(walkthroughs: state.walkthroughs),
                      ]),
                    ),
                  ),
                ],
              ),
              
              const DeliverablesAppBar(),
              
              const DeliverablesStickyActions(),
            ],
          );
        },
      ),
    );
  }
}
