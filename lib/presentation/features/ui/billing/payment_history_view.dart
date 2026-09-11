import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_history_cubit.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_history_state.dart';
import 'package:acrova/presentation/features/ui/billing/widgets/payment_list_item.dart';
import 'package:acrova/utils/enums/payment_filter_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocatorInstance<PaymentHistoryCubit>()..fetchPayments(),
      child: const _PaymentHistoryContent(),
    );
  }
}

class _PaymentHistoryContent extends StatelessWidget {
  const _PaymentHistoryContent();

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return CommonScreen(
      appBar: AppAuthBrandHeader(label: loc.billingTitle, showBack: true),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              Resources.horizontalDims.$24,
              Resources.verticalDims.$24,
              Resources.horizontalDims.$24,
              Resources.verticalDims.$16,
            ),
            child: Text(
              loc.paymentHistoryTitle,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: Resources.fontWeights.semiBold,
                color: Resources.colors.luxuryNavy,
              ),
            ),
          ),
          // Filters
          SizedBox(
            height: Resources.verticalDims.$36,
            child: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
              buildWhen: (p, c) =>
                  p.selectedFilter != c.selectedFilter ||
                  p.isLoading != c.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return const _PaymentHistoryShimmerFilters();
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: Resources.horizontalDims.$24,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: PaymentFilter.values.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: Resources.horizontalDims.$8),
                  itemBuilder: (context, index) {
                    final filter = PaymentFilter.values[index];
                    final isSelected = filter == state.selectedFilter;
                    return GestureDetector(
                      onTap: () => context
                          .read<PaymentHistoryCubit>()
                          .updateFilter(filter),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Resources.horizontalDims.$16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Resources.colors.luxuryNavy
                              : Resources.colors.transparent,
                          borderRadius: BorderRadius.circular(
                            Resources.radius.$r20,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? Resources.colors.luxuryNavy
                                : Resources.colors.luxuryBorder,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          filter.localizedLabel(context),
                          style: context.textTheme.labelMedium?.copyWith(
                            color: isSelected
                                ? Resources.colors.white
                                : Resources.colors.luxuryNavy,
                            fontWeight: isSelected
                                ? Resources.fontWeights.semiBold
                                : Resources.fontWeights.medium,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: Resources.verticalDims.$24),
          // Main List Area
          Expanded(
            child: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CommonShimmerLoading();
                }
                if (state.isError) {
                  return CommonErrorWidget(
                    error: state.error,
                    onRetry: () =>
                        context.read<PaymentHistoryCubit>().fetchPayments(),
                  );
                }
                if (state.isEmpty) {
                  return const _PaymentHistoryEmptyState();
                }
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    Resources.horizontalDims.$24,
                    0,
                    Resources.horizontalDims.$24,
                    Resources.verticalDims.$32,
                  ),
                  itemCount: state.filteredPayments.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Resources.verticalDims.$12),
                  itemBuilder: (context, index) {
                    final payment = state.filteredPayments[index];
                    return PaymentListItem(
                      payment: payment,
                      onTap: () {
                        context.push(
                          AppRouteEnum.paymentDetailsPage.path,
                          extra: PaymentDetailsArgs(paymentId: payment.id),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentHistoryShimmerFilters extends StatelessWidget {
  const _PaymentHistoryShimmerFilters();

  static const _widths = [80.0, 100.0, 90.0, 110.0];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$24),
      scrollDirection: Axis.horizontal,
      itemCount: _widths.length,
      separatorBuilder: (_, __) => SizedBox(width: Resources.horizontalDims.$8),
      itemBuilder: (context, index) {
        return Container(
          width: _widths[index],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Resources.radius.$r20),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Resources.colors.luxuryBorder.withValues(alpha: 0.3),
            highlightColor: Resources.colors.luxuryBorder.withValues(
              alpha: 0.1,
            ),
            child: Container(
              width: _widths[index] * 0.6,
              height: Resources.verticalDims.$12,
              decoration: BoxDecoration(
                color: Resources.colors.white,
                borderRadius: BorderRadius.circular(Resources.radius.$r4),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PaymentHistoryEmptyState extends StatelessWidget {
  const _PaymentHistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Resources.squareDims.$96,
            height: Resources.squareDims.$96,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.account_balance_outlined,
              size: Resources.iconSizes.$48,
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$24),
          Text(
            loc.paymentHistoryEmptyTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            loc.paymentHistoryEmptySubtitle,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryBody,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Resources.verticalDims.$32),
          AppPrimaryButton(
            label: loc.paymentHistoryStartNewProject,
            onPressed: () {
              context.go(AppRouteEnum.projectCreationPage.path);
            },
          ),
        ],
      ),
    );
  }
}
