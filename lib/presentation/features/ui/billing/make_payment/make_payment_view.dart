import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/cubit/make_payment_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/cubit/make_payment_state.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/widgets/amount_due_card.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/widgets/bank_details_card.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/widgets/upload_portal.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/formatters/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MakePaymentView extends StatelessWidget {
  const MakePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<MakePaymentCubit>()..fetchQuote(),
      child: const _MakePaymentContent(),
    );
  }
}

class _MakePaymentContent extends StatelessWidget {
  const _MakePaymentContent();

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return BlocConsumer<MakePaymentCubit, MakePaymentState>(
      listener: _handleMakePaymentListener,
      builder: (context, state) {
        return CommonScreen(
          bottomPadding: 0,
          bottomNavigationBar: state.isError
              ? null
              : Container(
                  padding: EdgeInsets.only(
                    top: Resources.verticalDims.$16,
                    left: Resources.horizontalDims.$24,
                    right: Resources.horizontalDims.$24,
                    bottom: Resources.verticalDims.$32,
                  ),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxurySurface,
                    boxShadow: [
                      BoxShadow(
                        color: Resources.colors.luxuryInk.withValues(
                          alpha: 0.05,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: AppPrimaryButton(
                    label: loc.makePaymentUploadAndPay,
                    isLoading: state.submittingStatus == CubitStatus.loading,
                    enabled: state.receiptImage != null,
                    onPressed: () {
                      context.read<MakePaymentCubit>().submitPayment();
                    },
                  ),
                ),
          appBar: AppAuthBrandHeader(
            showBack: true,
            label: loc.makePaymentTitle,
          ),
          child: MakePaymentBody(state: state),
        );
      },
    );
  }

  void _handleMakePaymentListener(
    BuildContext context,
    MakePaymentState state,
  ) {
    if (state.submittingStatus == CubitStatus.success) {
      context.go(
        AppRouteEnum.paymentSuccessPage.path,
        extra: PaymentSuccessArgs(
          amount: state.quote != null
              ? (AppFormatter.formatAmount(state.quote!.amountDue) ?? '')
              : '',
        ),
      );
    }
  }
}

class MakePaymentBody extends StatelessWidget {
  const MakePaymentBody({super.key, required this.state});

  final MakePaymentState state;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    if (state.isLoading) {
      return const CommonShimmerLoading(
        isDetail: true,
        padding: EdgeInsets.zero,
      );
    }

    if (state.isError) {
      return CommonErrorWidget(
        error: state.fetchQuoteError,
        onRetry: () {
          context.read<MakePaymentCubit>().fetchQuote();
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AmountDueCard(quote: state.quote),
                SizedBox(height: Resources.verticalDims.$32),
                BankDetailsCard(quote: state.quote),
                SizedBox(height: Resources.verticalDims.$32),
                UploadPortal(state: state),
                SizedBox(height: Resources.verticalDims.$32),
                Text(
                  loc.makePaymentManualReviewNotice,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Resources.colors.luxuryBody.withValues(alpha: 0.8),
                    height: Resources.lineHeights.$1_5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Resources.verticalDims.$32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
