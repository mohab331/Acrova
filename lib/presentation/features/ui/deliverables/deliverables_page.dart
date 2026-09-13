import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_secondary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/ui/deliverables/cubit/deliverables_cubit.dart';
import 'package:acrova/presentation/features/ui/deliverables/cubit/deliverables_state.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/blueprints_section.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/deliverables_loading_skeleton.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/renders_section.dart';
import 'package:acrova/presentation/features/ui/deliverables/widgets/walkthroughs_section.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final loc = context.localization;

    return BlocBuilder<DeliverablesCubit, DeliverablesState>(
      builder: (context, state) {
        return CommonScreen(
          bottomPadding: 0,
          bottomNavigationBar: state.isError || state.isLoading
              ? null
              : Container(
                  padding: EdgeInsetsDirectional.only(
                    top: Resources.verticalDims.$16,
                    start: Resources.horizontalDims.$24,
                    end: Resources.horizontalDims.$24,
                    bottom: Resources.verticalDims.$32,
                  ),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxurySurface,
                    boxShadow: [
                      BoxShadow(
                        color: Resources.colors.luxuryInk.withValues(
                          alpha: 0.05,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppPrimaryButton(
                        onPressed: () {
                          context.go(AppRouteEnum.homePage.path);
                        },
                        label: loc.deliverablesApprove,
                      ),
                      SizedBox(height: Resources.verticalDims.$8),
                      AppSecondaryButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRouteEnum.revisionRequestPage.name,
                          );
                        },
                        label: loc.deliverablesRequestRevision,
                      ),
                    ],
                  ),
                ),
          appBar: AppAuthBrandHeader(
            showBack: true,
            label: loc.deliverablesTitle,
          ),
          child: _DeliverablesBody(state: state),
        );
      },
    );
  }
}

class _DeliverablesBody extends StatelessWidget {
  const _DeliverablesBody({required this.state});

  final DeliverablesState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const DeliverablesLoadingSkeleton();
    }

    if (state.isError) {
      return CommonErrorWidget(
        error: state.error,
        onRetry: () {
          context.read<DeliverablesCubit>().fetchDeliverables();
        },
      );
    }

    final hasDeliverables =
        state.blueprints.isNotEmpty ||
        state.renders.isNotEmpty ||
        state.walkthroughs.isNotEmpty;

    if (!hasDeliverables) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            if (state.blueprints.isNotEmpty) ...[
              BlueprintsSection(blueprints: state.blueprints),
              SizedBox(height: Resources.verticalDims.$32),
            ],
            if (state.renders.isNotEmpty) ...[
              RendersSection(renders: state.renders),
              SizedBox(height: Resources.verticalDims.$32),
            ],
            if (state.walkthroughs.isNotEmpty)
              WalkthroughsSection(walkthroughs: state.walkthroughs),
          ]),
        ),
      ],
    );
  }
}
