import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_history_cubit.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_history_state.dart';
import 'package:acrova/presentation/features/ui/billing/widgets/payment_list_item.dart';
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
      create: (_) => serviceLocatorInstance<PaymentHistoryCubit>()..fetchPayments(),
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
      appBar: AppAuthBrandHeader(
        label: loc.billingTitle,
        showBack: true,
      ),
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
            height: 36,
            child: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
              buildWhen: (p, c) =>
                  p.selectedFilter != c.selectedFilter || p.isLoading != c.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return const _PaymentHistoryShimmerFilters();
                }
                final filterItems = [
                  (id: 'All', label: loc.filterAll),
                  (id: 'Success', label: loc.filterSuccess),
                  (id: 'Pending', label: loc.filterPending),
                  (id: 'Rejected', label: loc.filterRejected),
                ];
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$24),
                  scrollDirection: Axis.horizontal,
                  itemCount: filterItems.length,
                  separatorBuilder: (_, __) => SizedBox(width: Resources.horizontalDims.$8),
                  itemBuilder: (context, index) {
                    final item = filterItems[index];
                    final isSelected = item.id == state.selectedFilter;
                    return GestureDetector(
                      onTap: () =>
                          context.read<PaymentHistoryCubit>().updateFilter(item.id),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Resources.horizontalDims.$16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Resources.colors.luxuryNavy
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? Resources.colors.luxuryNavy
                                : Resources.colors.luxuryBorder,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          item.label,
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
                  return const _PaymentHistoryShimmerList();
                }
                if (state.status == PaymentHistoryStatus.failure) {
                  return _PaymentHistoryErrorState(state: state);
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
                          extra: payment.id,
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
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Resources.colors.luxuryBorder.withValues(alpha: 0.3),
            highlightColor: Resources.colors.luxuryBorder.withValues(alpha: 0.1),
            child: Container(
              width: _widths[index] * 0.6,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PaymentHistoryShimmerList extends StatelessWidget {
  const _PaymentHistoryShimmerList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$24),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: Resources.verticalDims.$12),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(Resources.horizontalDims.$16),
          decoration: BoxDecoration(
            color: Resources.colors.luxurySurface,
            borderRadius: BorderRadius.circular(Resources.radius.$r8),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          child: Shimmer.fromColors(
            baseColor: Resources.colors.luxuryBorder.withValues(alpha: 0.3),
            highlightColor: Resources.colors.luxuryBorder.withValues(alpha: 0.1),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$8),
                    Container(
                      width: 40,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
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
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.account_balance_outlined,
              size: 48,
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
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                context.go(AppRouteEnum.projectCreationPage.path);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Resources.colors.luxuryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: Resources.colors.luxuryNavy.withValues(alpha: 0.3),
              ),
              child: Text(
                loc.paymentHistoryStartNewProject,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: Resources.fontWeights.bold,
                  color: Resources.colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentHistoryErrorState extends StatelessWidget {
  const _PaymentHistoryErrorState({required this.state});

  final PaymentHistoryState state;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryError.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Resources.colors.luxuryError.withValues(alpha: 0.2),
              ),
            ),
            alignment: Alignment.center,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryError.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: Resources.colors.luxuryError,
              ),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$24),
          Text(
            state.error?.title ?? loc.paymentHistoryErrorTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            state.error?.message ?? loc.paymentHistoryErrorMessage,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryBody,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Resources.verticalDims.$32),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<PaymentHistoryCubit>().fetchPayments();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Resources.colors.luxuryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: Resources.colors.luxuryNavy.withValues(alpha: 0.3),
              ),
              icon: Icon(Icons.refresh, color: Resources.colors.white),
              label: Text(
                loc.paymentHistoryTryAgain,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: Resources.fontWeights.bold,
                  color: Resources.colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
