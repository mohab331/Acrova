import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_details_cubit.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_details_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/formatters/app_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({required this.paymentId, super.key});

  final String paymentId;

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

  final String paymentId;

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
          return _PaymentDetailsCard(payment: state.payment!);
        },
      ),
    );
  }
}

class _PaymentDetailsCard extends StatelessWidget {
  const _PaymentDetailsCard({required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final statusColor = payment.status.color;
    final isSuccess = payment.status == PaymentStatus.success;
    final isRejected = payment.status == PaymentStatus.rejected;
    final isPending = payment.status == PaymentStatus.pending;
    final formattedAmount = AppFormatter.formatAmount(payment.amount);
    final formattedDate = AppFormatter.formatDate(
      payment.date,
      locale: Localizations.localeOf(context).languageCode,
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      child: Container(
        decoration: BoxDecoration(
          color: Resources.colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Resources.radius.$r16),
            topRight: Radius.circular(Resources.radius.$r16),
            bottomLeft: Radius.circular(Resources.radius.$r8),
            bottomRight: Radius.circular(Resources.radius.$r8),
          ),
          boxShadow: [
            BoxShadow(
              color: Resources.colors.luxuryInk.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Status Banner
            Container(
              height: Resources.verticalDims.$4,
              width: double.infinity,
              color: statusColor.withValues(alpha: 0.8),
            ),
            Padding(
              padding: EdgeInsets.all(Resources.horizontalDims.$24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Column(
                    children: [
                      Icon(
                        payment.status.icon,
                        color: statusColor,
                        size: Resources.iconSizes.$48,
                      ),
                      SizedBox(height: Resources.verticalDims.$8),
                      Text(
                        loc.paymentDetailsPaymentStatus(
                          payment.status.localizedName(context),
                        ),
                        style: context.textTheme.labelMedium?.copyWith(
                          color: isRejected
                              ? statusColor
                              : Resources.colors.luxuryBody,
                          letterSpacing: 1.5,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$8),
                      Text(
                        '${payment.currency} $formattedAmount',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.luxuryNavy,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$24),
                  Divider(
                    color: Resources.colors.luxuryBorder.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: Resources.verticalDims.$24),

                  // Project Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.paymentDetailsProject,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Resources.colors.luxuryBody,
                          letterSpacing: 1.5,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$4),
                      Text(
                        payment.projectName,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.luxuryNavy,
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$4),
                      Text(
                        loc.paymentDetailsId(payment.projectId),
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Resources.colors.luxuryBody,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$24),

                  // Grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PaymentGridItem(
                              label: loc.paymentDetailsTransactionId,
                              value: payment.transactionId,
                            ),
                            SizedBox(height: Resources.verticalDims.$16),
                            _PaymentGridItem(
                              label: loc.paymentDetailsBank,
                              value: payment.bankName,
                            ),
                            if (isSuccess) ...[
                              SizedBox(height: Resources.verticalDims.$16),
                              _PaymentGridItem(
                                label: loc.paymentDetailsAccountName,
                                value: payment.accountName,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PaymentGridItem(
                              label: loc.paymentDetailsDate,
                              value: formattedDate ?? '',
                            ),
                            SizedBox(height: Resources.verticalDims.$16),
                            _PaymentGridItem(
                              label: loc.paymentDetailsIban,
                              value: payment.iban,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (isRejected && payment.rejectionReason != null) ...[
                    SizedBox(height: Resources.verticalDims.$24),
                    Container(
                      padding: EdgeInsets.all(Resources.horizontalDims.$16),
                      decoration: BoxDecoration(
                        color: Resources.colors.luxuryErrorLight,
                        border: Border.all(color: Resources.colors.luxuryError),
                        borderRadius: BorderRadius.circular(
                          Resources.radius.$r8,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.paymentDetailsPaymentRejected,
                            style: context.textTheme.titleSmall?.copyWith(
                              color: Resources.colors.luxuryError,
                              fontWeight: Resources.fontWeights.semiBold,
                            ),
                          ),
                          SizedBox(height: Resources.verticalDims.$4),
                          Text(
                            payment.rejectionReason!,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Resources.colors.luxuryError.withValues(
                                alpha: 0.9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (payment.receiptUrl != null) ...[
                    SizedBox(height: Resources.verticalDims.$24),
                    Container(
                      padding: EdgeInsets.all(Resources.horizontalDims.$16),
                      decoration: BoxDecoration(
                        color: Resources.colors.luxurySurface,
                        borderRadius: BorderRadius.circular(
                          Resources.radius.$r8,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                color: Resources.colors.luxuryBody,
                              ),
                              SizedBox(width: Resources.horizontalDims.$8),
                              Text(
                                loc.paymentDetailsTransferReceipt,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: Resources.colors.luxuryNavy,
                                  fontWeight: Resources.fontWeights.medium,
                                ),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Resources.radius.$r8,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: payment.receiptUrl!,
                              width: Resources.squareDims.$80,
                              height: Resources.squareDims.$80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: Resources.squareDims.$80,
                                height: Resources.squareDims.$80,
                                color: Resources.colors.luxuryBorder.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (isSuccess || isPending) ...[
                    SizedBox(height: Resources.verticalDims.$24),
                    SizedBox(
                      width: double.infinity,
                      height: Resources.verticalDims.$48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (isPending) {
                            context.pushNamed(
                              AppRouteEnum.makePaymentPage.name,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Resources.colors.luxuryNavy,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Resources.radius.$r8,
                            ),
                          ),
                          elevation: 2,
                        ),
                        icon: Icon(
                          Icons.download,
                          color: Resources.colors.white,
                          size: Resources.iconSizes.$20,
                        ),
                        label: Text(
                          isPending
                              ? loc.paymentDetailsPay
                              : loc.paymentDetailsDownloadPdf,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: Resources.fontWeights.medium,
                            color: Resources.colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentGridItem extends StatelessWidget {
  const _PaymentGridItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: Resources.colors.luxuryBody,
            letterSpacing: 1.5,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$4),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
      ],
    );
  }
}
