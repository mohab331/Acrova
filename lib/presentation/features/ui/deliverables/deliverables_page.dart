import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_secondary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
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
import 'package:go_router/go_router.dart';

import '../../../../utils/enums/cubit_status.dart';

class DeliverablesPage extends StatelessWidget {
  const DeliverablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocatorInstance<DeliverablesCubit>()..fetchDeliverables(),
      child: const _DeliverablesView(),
    );
  }
}

class _DeliverablesView extends StatelessWidget {
  const _DeliverablesView();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: Resources.verticalDims.$16,
          left: Resources.horizontalDims.$24,
          right: Resources.horizontalDims.$24,
          bottom: Resources.verticalDims.$32,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Resources.colors.luxuryInk.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        height: 167,
        child: Column(
          children: [
            AppPrimaryButton(
              onPressed: () {
                // Return to home dashboard
                context.go(AppRouteEnum.homePage.path);
              },
              label: 'Approve Deliverables',
            ),
            SizedBox(height: 8,),
            AppSecondaryButton(
              onPressed: () {
                context.pushNamed(AppRouteEnum.revisionRequestPage.name);
              },
              label: 'Request revision',
            ),
          ],
        ),
      ),
      appBar: const AppAuthBrandHeader(showBack: true,label: 'Deliverables',),
      child: BlocBuilder<DeliverablesCubit, DeliverablesState>(
        builder: (context, state) {
          if (state.status == CubitStatus.loading ||
              state.status == CubitStatus.initial) {
            return const DeliverablesLoadingSkeleton();
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  BlueprintsSection(blueprints: state.blueprints),
                  SizedBox(height: Resources.verticalDims.$32),
                  RendersSection(renders: state.renders),
                  SizedBox(height: Resources.verticalDims.$32),
                  WalkthroughsSection(walkthroughs: state.walkthroughs),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
