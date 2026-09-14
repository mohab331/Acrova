import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_app_bar.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/cubit/interior_design_list_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/cubit/interior_design_list_state.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/widgets/interior_design_card.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/widgets/interior_design_list_header.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/widgets/interior_design_list_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignListPage extends StatelessWidget {
  const InteriorDesignListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<InteriorDesignListCubit>()
            ..fetchInteriorDesigns(),
      child: const _InteriorDesignListView(),
    );
  }
}

class _InteriorDesignListView extends StatelessWidget {
  const _InteriorDesignListView();

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return CommonScreen(
      bottomPadding: 0,
      appBar: AppAppBar(
        title: loc.interiorDesignListTitle,
      ),
      child: BlocBuilder<InteriorDesignListCubit, InteriorDesignListState>(
        builder: (context, state) {
          if (state.isLoading || state.cubitStatus == CubitStatus.initial) {
            return const InteriorDesignListSkeleton();
          }

          if (state.isError) {
            return CommonErrorWidget(
              error: state.appErrorModel,
              onRetry: () =>
                  context.read<InteriorDesignListCubit>().fetchInteriorDesigns(),
            );
          }

          final filtered = state.filteredItems;

          return RefreshIndicator(
            color: Resources.colors.luxuryGoldLight,
            onRefresh: () =>
                context.read<InteriorDesignListCubit>().fetchInteriorDesigns(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: InteriorDesignListHeader(
                    filter: state.filter,
                    onFilterChanged: (filter) => context
                        .read<InteriorDesignListCubit>()
                        .setFilter(filter),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Resources.verticalDims.$20),
                ),
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: AppEmptyState(
                      icon: Icons.chair_outlined,
                      title: loc.interiorDesignEmptyTitle,
                      subtitle: loc.interiorDesignEmptySubtitle,
                      ctaLabel: loc.dashboardActionNewProject,
                      onCtaTap: () => context.push(
                        AppRouteEnum.projectsPage.path,
                      ),
                    ),
                  )
                else
                  SliverList.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: Resources.verticalDims.$16,
                    ),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return InteriorDesignCard(
                        item: item,
                        onTap: () {
                          context.push(
                            AppRouteEnum.interiorDesignDetailPage.path,
                            extra: InteriorDesignDetailArgs(
                              id: item.id,
                              interiorDesign: item,
                            ),
                          );
                        },
                      );
                    },
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Resources.verticalDims.$32),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
