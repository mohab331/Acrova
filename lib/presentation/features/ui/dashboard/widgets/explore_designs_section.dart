import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:acrova/presentation/features/common_widgets/layout/app_section_header.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_design_gallery.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExploreDesignsSection extends StatelessWidget {
  const ExploreDesignsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final portfolioCubit = context.read<PortfolioCubit>();
    final portfolioState = context.watch<PortfolioCubit>().state;
    if (portfolioState.isSuccess && (portfolioState.items.isEmpty)) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSectionHeader(
          title: loc.dashboardExploreDesigns,
          actionLabel: loc.dashboardGallery,
          onActionTap: () => context.goNamed(AppRouteEnum.portfolioPage.name),
          bottomSpacing: Resources.verticalDims.$16,
        ),

        if (portfolioState.isLoading) ...[
          SkeletonBox(
            width: double.infinity,
            height: Resources.verticalDims.$100,
            radius: Resources.radius.$r8,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Row(
            children: [
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: Resources.verticalDims.$60,
                  radius: Resources.radius.$r8,
                ),
              ),
              SizedBox(width: Resources.horizontalDims.$12),
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: Resources.verticalDims.$60,
                  radius: Resources.radius.$r8,
                ),
              ),
            ],
          ),
        ] else if (portfolioState.isError)
          Center(
            child: AppErrorState(
              onRetry: portfolioCubit.fetchPortfolio,
              errorModel: portfolioState.error,
            ),
          )
        else
          DashboardDesignGallery(portfolioItems: portfolioState.items),
      ],
    );
  }
}
