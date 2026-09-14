import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/ui/projects/cubit/projects_cubit.dart';
import 'package:acrova/presentation/features/ui/projects/cubit/projects_state.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/featured_project_card.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/projects_section_header.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/projects_skeleton.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/standard_project_card.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/bottom_nav_reselect_scope.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/project_filter_enum.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ProjectFilter _filter = ProjectFilter.all;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<ProjectModel> _applyFilter(List<ProjectModel> all) {
    return switch (_filter) {
      ProjectFilter.all => all,
      ProjectFilter.active =>
        all.where((p) => !(p.status?.isTerminal ?? false)).toList(),
      ProjectFilter.completed =>
        all.where((p) => (p.status?.isTerminal ?? false)).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectsCubit>(
      create: (context) =>
          serviceLocatorInstance<ProjectsCubit>()..fetchProjects(),
      child: CommonScreen(
        bottomPadding: 0,
        child: BlocBuilder<ProjectsCubit, ProjectsCubitState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state.isLoading ||
                          state.cubitStatus == CubitStatus.initial) {
                        return const ProjectsSkeleton();
                      }
                      if (state.isError) {
                        return CommonErrorWidget(
                          error: state.appErrorModel,
                          onRetry: () =>
                              context.read<ProjectsCubit>().fetchProjects(),
                        );
                      }

                      final filtered = _applyFilter(state.projects ?? []);

                      return BottomNavScrollAndRefreshListener(
                        tabIndex: 1,
                        scrollController: _scrollController,
                        refreshIndicatorKey: _refreshIndicatorKey,
                        onRefresh: () =>
                            context.read<ProjectsCubit>().fetchProjects(),
                        child: RefreshIndicator(
                          key: _refreshIndicatorKey,
                          color: Resources.colors.luxuryGoldLight,
                          onRefresh: () =>
                              context.read<ProjectsCubit>().fetchProjects(),
                          child: CustomScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: ProjectsSectionHeader(
                                  filter: _filter,
                                  onFilterChanged: (f) =>
                                      setState(() => _filter = f),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: Resources.verticalDims.$20,
                                ),
                              ),
                              if (filtered.isEmpty)
                                SliverFillRemaining(
                                  child: AppEmptyState(
                                    icon: Icons.folder_open_outlined,
                                    title:
                                        context.localization.projectsEmptyTitle,
                                    subtitle: context
                                        .localization
                                        .projectsEmptySubtitle,
                                    ctaLabel: context
                                        .localization
                                        .dashboardActionNewProject,
                                    onCtaTap: () => context.push(
                                      AppRouteEnum.projectCreationPage.path,
                                    ),
                                  ),
                                )
                              else ...[
                                if (filtered.isNotEmpty) ...[
                                  SliverToBoxAdapter(
                                    child: GestureDetector(
                                      onTap: () {
                                        final p = filtered.firstOrNull;
                                        if (p == null) return;
                                        context.push(
                                          AppRouteEnum.projectDetailPage.name,
                                          extra: ProjectDetailArgs(
                                            id: p.id ?? '',
                                            title: p.name,
                                          ),
                                        );
                                      },
                                      child: FeaturedProjectCard(
                                        project: filtered.first,
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: Resources.verticalDims.$16,
                                    ),
                                  ),
                                ],
                                if (filtered.length > 1)
                                  SliverList.separated(
                                    itemCount: filtered.length - 1,
                                    separatorBuilder: (_, __) => SizedBox(
                                      height: Resources.verticalDims.$16,
                                    ),
                                    itemBuilder: (_, i) => GestureDetector(
                                      onTap: () {
                                        final p = filtered[i + 1];
                                        context.push(
                                          AppRouteEnum.projectDetailPage.name,
                                          extra: ProjectDetailArgs(
                                            id: p.id ?? '',
                                            title: p.name,
                                          ),
                                        );
                                      },
                                      child: StandardProjectCard(
                                        project: filtered[i + 1],
                                      ),
                                    ),
                                  ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: Resources.verticalDims.$32,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
