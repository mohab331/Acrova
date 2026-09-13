import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/ui/billing/payment_details/cubit/payment_details_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/payment_details/cubit/payment_details_state.dart';
import 'package:acrova/presentation/features/ui/billing/payment_details/widgets/payment_details_card.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({required this.paymentId, super.key});

  final String? paymentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocatorInstance<PaymentDetailsCubit>()
            ..fetchPaymentDetails(paymentId),
      child: _PaymentDetailsContent(paymentId: paymentId),
    );
  }
}

class _PaymentDetailsContent extends StatelessWidget {
  const _PaymentDetailsContent({required this.paymentId});

  final String? paymentId;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return CommonScreen(
      appBar: AppAuthBrandHeader(
        label: loc.paymentDetailsTitle,
        showBack: true,
      ),
      padding: EdgeInsets.zero,
      child: BlocBuilder<PaymentDetailsCubit, PaymentDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CommonShimmerLoading(isDetail: true);
          }
          if (state.isError) {
            return CommonErrorWidget(
              error: state.error,
              onRetry: () => context
                  .read<PaymentDetailsCubit>()
                  .fetchPaymentDetails(paymentId),
            );
          }
          if (state.payment == null) {
            return const SizedBox();
          }
          return PaymentDetailsCard(payment: state.payment!);
        },
      ),
    );
  }
}
