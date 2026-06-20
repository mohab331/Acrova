import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_avatar_header.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/layout/app_section_header.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_design_gallery.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_hero_banner.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_project_card_item.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_quick_actions_grid.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({required this.data, super.key});

  final DashboardDataModel data;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return RefreshIndicator(
      color: Resources.colors.luxuryGoldLight,
      onRefresh: () => context.read<DashboardCubit>().fetchDashboardData(),
      child: Column(
        children: [
          AvatarHeader(
            userName: data.userName,
            notificationCount: data.notificationCount,
            avatarUrl: data.avatarUrl,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DashboardHeroBanner(),
                  SizedBox(height: Resources.verticalDims.$32),
                  AppSectionHeader(
                    title: loc.dashboardYourProjects,
                    actionLabel: loc.dashboardViewAll,
                    onActionTap: () =>
                        context.go(AppRouteEnum.projectsPage.path),
                    bottomSpacing: Resources.verticalDims.$16,
                  ),
                  if (data.recentProjects.isEmpty)
                    AppEmptyState(
                      icon: Icons.folder_open_outlined,
                      title: loc.dashboardNoProjectsTitle,
                      subtitle: loc.dashboardNoProjectsSubtitle,
                      ctaLabel: loc.dashboardActionNewProject,
                      onCtaTap: () =>
                          context.push(AppRouteEnum.projectCreationPage.path),
                    )
                  else
                    Column(
                      children: data.recentProjects
                          .map(
                            (p) => Padding(
                              padding: EdgeInsets.only(
                                bottom: Resources.verticalDims.$12,
                              ),
                              child: DashboardProjectCardItem(project: p),
                            ),
                          )
                          .toList(),
                    ),
                  SizedBox(height: Resources.verticalDims.$20),
                  Text(
                    loc.dashboardQuickActions,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontSize: Resources.fontSizes.$20,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$16),
                  const DashboardQuickActionsGrid(),
                  SizedBox(height: Resources.verticalDims.$32),
                  AppSectionHeader(
                    title: loc.dashboardExploreDesigns,
                    actionLabel: loc.dashboardGallery,
                    onActionTap: () =>
                        context.goNamed(AppRouteEnum.portfolioPage.name),
                    bottomSpacing: Resources.verticalDims.$16,
                  ),
                  DashboardDesignGallery(designs: data.exploreDesigns),
                  SizedBox(height: Resources.verticalDims.$32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
