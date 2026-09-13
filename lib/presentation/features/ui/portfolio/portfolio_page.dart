import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_state.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_filter_row.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_gallery_grid.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_hero_card.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/projects_skeleton.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<PortfolioCubit>()..fetchPortfolio(),
      child: const _PortfolioPageView(),
    );
  }
}

class _PortfolioPageView extends StatelessWidget {
  const _PortfolioPageView();

  void _openDetail(BuildContext context, PortfolioItem item) {
    context.pushNamed(
      AppRouteEnum.portfolioDetailPage.name,
      extra: PortfolioDetailArgs(portfolioItem: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const ProjectsSkeleton();
          }
          if (state.isError && state.items.isEmpty) {
            return CommonErrorWidget(
              error: state.error,
              onRetry: () => context.read<PortfolioCubit>().fetchPortfolio(),
            );
          }

          final items = state.getFilteredItems(context);

          return RefreshIndicator(
            onRefresh: () => context.read<PortfolioCubit>().fetchPortfolio(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.localization.portfolioExploreTitle,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    context.localization.portfolioExploreSubtitle,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  PortfolioFilterRow(
                    selected: state.filter,
                    onSelect: (f) =>
                        context.read<PortfolioCubit>().setFilter(f),
                    filters: state.filters,
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  if (items.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: Resources.verticalDims.$80),
                      child: Center(
                        child: Text(
                          context.localization.noDesignsCategory,
                          style: TextStyle(
                            fontSize: Resources.fontSizes.$14,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                        ),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PortfolioHeroCard(
                          item: items.first,
                          onTap: () => _openDetail(context, items.first),
                        ),
                        if (items.length > 1) ...[
                          SizedBox(height: Resources.verticalDims.$20),
                          PortfolioGalleryGrid(
                            items: items.skip(1).toList(),
                            onTap: (item) => _openDetail(context, item),
                          ),
                        ],
                      ],
                    ),
                  SizedBox(height: Resources.verticalDims.$32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
