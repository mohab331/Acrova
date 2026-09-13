import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_hero_banner.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/explore_designs_section.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/quick_actions_section.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/recent_projects_section.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:acrova/presentation/features/ui/projects/cubit/projects_cubit.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/bottom_nav_reselect_scope.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final portfolioCubit = context.read<PortfolioCubit>();
    final projectsCubit = context.read<ProjectsCubit>();
    final authCubit = context.read<AuthCubit>();

    final portfolioState = context.watch<PortfolioCubit>().state;
    final projectsState = context.watch<ProjectsCubit>().state;
    final authState = context.watch<AuthCubit>().state;

    final isVisitor = authState.isVisitor;
    final isDashboardError = isVisitor
        ? portfolioState.isError
        : (portfolioState.isError && projectsState.isError);

    if (isDashboardError) {
      return AppErrorState(
        onRetry: () {
          if (portfolioState.isError) portfolioCubit.fetchPortfolio();
          if (!isVisitor && projectsState.isError) projectsCubit.fetchProjects();
          if (authState.getUserCubitStatus == CubitStatus.error) {
            authCubit.getUser();
          }
        },
      );
    }

    return BottomNavScrollAndRefreshListener(
      tabIndex: 0,
      scrollController: _scrollController,
      refreshIndicatorKey: _refreshIndicatorKey,
      onRefresh: () => _onPullToRefresh(context),
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Resources.colors.luxuryGoldLight,
        onRefresh: () => _onPullToRefresh(context),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardHeroBanner(),
                    SizedBox(height: Resources.verticalDims.$32),

                    /// Recent Projects Section ------------------------
                    const RecentProjectsSection(),
                    SizedBox(height: Resources.verticalDims.$20),

                    /// Quick Actions Grid ------------------------
                    const QuickActionsSection(),
                    SizedBox(height: Resources.verticalDims.$32),

                    /// Explore Designs Section ------------------------
                    const ExploreDesignsSection(),
                    SizedBox(height: Resources.verticalDims.$32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<void>> _onPullToRefresh(BuildContext context) {
    final portfolioCubit = context.read<PortfolioCubit>();
    final projectsCubit = context.read<ProjectsCubit>();
    final authCubit = context.read<AuthCubit>();
    final isVisitor = authCubit.state.isVisitor;

    return Future.wait([
      portfolioCubit.fetchPortfolio(),
      if (!isVisitor) projectsCubit.fetchProjects(),
      authCubit.getUser(),
    ]);
  }
}
