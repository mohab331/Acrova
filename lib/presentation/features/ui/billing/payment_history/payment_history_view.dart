import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/visitor_empty_state.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/cubit/payment_history_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/cubit/payment_history_state.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/widgets/payment_filter.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/widgets/payment_history_empty_state.dart';
import 'package:acrova/presentation/features/ui/billing/widgets/payment_list_item.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = serviceLocatorInstance<PaymentHistoryCubit>();
        if (!context.read<AuthCubit>().state.isGuest) cubit.fetchPayments();
        return cubit;
      },
      child: const _PaymentHistoryContent(),
    );
  }
}

class _PaymentHistoryContent extends StatelessWidget {
  const _PaymentHistoryContent();

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    if (context.watch<AuthCubit>().state.isGuest) {
      return CommonScreen(
        appBar: AppAuthBrandHeader(label: loc.billingTitle, showBack: true),
        child: VisitorEmptyState(
          icon: Icons.receipt_long_outlined,
          title: loc.visitorPaymentHistoryTitle,
        ),
      );
    }

    return CommonScreen(
      appBar: AppAuthBrandHeader(label: loc.billingTitle, showBack: true),
      padding: EdgeInsets.zero,
      child: RefreshIndicator(
        color: Resources.colors.luxuryGoldLight,
        onRefresh: () => context.read<PaymentHistoryCubit>().fetchPayments(),
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
            const PaymentFilterWidget(),
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
                    return const PaymentHistoryEmptyState();
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
      ),
    );
  }
}
