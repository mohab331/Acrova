import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:acrova/presentation/features/common_widgets/layout/app_section_header.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_project_card_item.dart';
import 'package:acrova/presentation/features/ui/projects/cubit/projects_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecentProjectsSection extends StatelessWidget {
  const RecentProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final projectsCubit = context.read<ProjectsCubit>();
    final projectsState = context.watch<ProjectsCubit>().state;

    final projects = projectsState.projects;
    if (projectsState.isSuccess && (projects?.isEmpty ?? true)) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSectionHeader(
          title: loc.dashboardYourProjects,
          actionLabel: loc.dashboardViewAll,
          onActionTap: () => context.go(AppRouteEnum.projectsPage.path),
          bottomSpacing: Resources.verticalDims.$16,
        ),
        if (projectsState.isLoading)
          SkeletonBox(
            width: double.infinity,
            height: Resources.verticalDims.$100,
            radius: Resources.radius.$r8,
          )
        else if (projectsState.isError)
          Center(
            child: AppErrorState.section(
              onRetry: projectsCubit.fetchProjects,
              errorModel: projectsState.appErrorModel,
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final project = projects?[index];
              return DashboardProjectCardItem(project: project);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: Resources.verticalDims.$12);
            },
            itemCount: (projects?.length ?? 0) > 2
                ? 2
                : (projects?.length ?? 0),
          ),
      ],
    );
  }
}
