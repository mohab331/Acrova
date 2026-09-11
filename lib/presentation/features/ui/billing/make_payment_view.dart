import 'dart:io';

import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/billing/make_payment_cubit.dart';
import 'package:acrova/presentation/features/cubit/billing/make_payment_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MakePaymentView extends StatelessWidget {
  const MakePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MakePaymentCubit(
        billingRepo: serviceLocatorInstance<BaseBillingRepo>(),
      )..fetchQuote(),
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
      listener: (context, state) {
        if (state.status == MakePaymentStatus.success) {
          context.go(AppRouteEnum.paymentSuccessPage.path);
        }
      },
      builder: (context, state) {
        return CommonScreen(
          bottomPadding: 0,
          bottomNavigationBar: Container(
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
                  color: Resources.colors.luxuryInk.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: AppPrimaryButton(
              label: loc.makePaymentUploadAndPay,
              isLoading: state.status == MakePaymentStatus.uploading,
              onPressed: () {
                if (state.receiptImage != null) {
                  context.read<MakePaymentCubit>().submitPayment();
                } else {
                  context.go(AppRouteEnum.paymentSuccessPage.path);
                }
              },
            ),
          ),
          appBar: AppAuthBrandHeader(showBack: true, label: loc.makePaymentTitle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _AmountDueCard(quote: state.quote),
                      SizedBox(height: Resources.verticalDims.$32),
                      _BankDetailsCard(quote: state.quote),
                      SizedBox(height: Resources.verticalDims.$32),
                      _UploadPortal(state: state),
                      SizedBox(height: Resources.verticalDims.$32),
                      Text(
                        loc.makePaymentManualReviewNotice,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Resources.colors.luxuryBody.withValues(
                            alpha: 0.8,
                          ),
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
          ),
        );
      },
    );
  }
}

class _AmountDueCard extends StatelessWidget {
  const _AmountDueCard({this.quote});

  final PaymentQuoteModel? quote;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final currency = quote?.currency ?? 'SAR';
    final amountDue = quote?.amountDue != null
        ? NumberFormat('#,##0').format(quote!.amountDue)
        : '14,000';
    final baseFee = quote?.baseFee != null
        ? NumberFormat('#,##0').format(quote!.baseFee)
        : '10,000';
    final vat = quote?.vat != null
        ? NumberFormat('#,##0').format(quote!.vat)
        : '1,200';
    final total = quote?.total != null
        ? NumberFormat('#,##0').format(quote!.total)
        : '11,200';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Resources.colors.luxuryBorder),
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        boxShadow: AppShadows.card,
      ),
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.makePaymentAmountDue,
            style: context.textTheme.labelSmall?.copyWith(
              color: Resources.colors.luxuryBody,
              letterSpacing: Resources.letterSpacing.$1_2,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            '$currency $amountDue',
            style: context.textTheme.headlineLarge?.copyWith(
              color: Resources.colors.luxuryNavy,
              fontWeight: Resources.fontWeights.bold,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$16),
          _BreakdownRow(
            title: loc.makePaymentBaseFee,
            amount: '$currency $baseFee',
            isOdd: true,
            isFirst: true,
          ),
          _BreakdownRow(
            title: loc.makePaymentVat,
            amount: '$currency $vat',
            isOdd: false,
          ),
          _BreakdownRow(
            title: loc.makePaymentTotal,
            amount: '$currency $total',
            isOdd: true,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.title,
    required this.amount,
    required this.isOdd,
    this.isFirst = false,
    this.isLast = false,
  });

  final String title;
  final String amount;
  final bool isOdd;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOdd
            ? Resources.colors.luxurySurface
            : context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(Resources.radius.$r4) : Radius.zero,
          bottom: isLast ? Radius.circular(Resources.radius.$r4) : Radius.zero,
        ),
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Resources.colors.luxuryBorder)),
      ),
      padding: EdgeInsets.all(Resources.horizontalDims.$12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryBody,
              fontWeight: Resources.fontWeights.semiBold,
            ),
          ),
          Text(
            amount,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryNavy,
              fontWeight: Resources.fontWeights.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}

class _BankDetailsCard extends StatelessWidget {
  const _BankDetailsCard({this.quote});

  final PaymentQuoteModel? quote;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final bankName = quote?.bankName.isNotEmpty == true
        ? quote!.bankName
        : loc.bankNameDefault;
    final iban = quote?.iban.isNotEmpty == true
        ? quote!.iban
        : 'SA00 1000 0000 0000 0000 0000';
    final accountName = quote?.accountName.isNotEmpty == true
        ? quote!.accountName
        : loc.bankAccountNameDefault;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Resources.colors.luxuryBorder),
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        boxShadow: AppShadows.card,
      ),
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.makePaymentBankTransferDetails,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Resources.colors.luxuryNavy,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$16),
          _BankInfoItem(
            label: loc.makePaymentBankName,
            value: bankName,
            hasCopy: false,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          _BankInfoItem(
            label: loc.makePaymentIban,
            value: iban,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          _BankInfoItem(
            label: loc.makePaymentAccountName,
            value: accountName,
          ),
        ],
      ),
    );
  }
}

class _BankInfoItem extends StatelessWidget {
  const _BankInfoItem({
    required this.label,
    required this.value,
    this.hasCopy = true,
  });

  final String label;
  final String value;
  final bool hasCopy;

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.localization.copiedToClipboard)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Resources.colors.luxuryGoldLight,
                  letterSpacing: Resources.letterSpacing.$1_2,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$4),
              Text(
                value,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                  letterSpacing: label == loc.makePaymentIban ? -0.5 : null,
                ),
              ),
            ],
          ),
        ),
        if (hasCopy)
          GestureDetector(
            onTap: () => _copyToClipboard(context, value),
            child: Text(
              loc.makePaymentCopy,
              style: context.textTheme.labelMedium?.copyWith(
                color: Resources.colors.luxuryGoldLight,
              ),
            ),
          ),
      ],
    );
  }
}

class _UploadPortal extends StatelessWidget {
  const _UploadPortal({required this.state});

  final MakePaymentState state;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null && context.mounted) {
      context.read<MakePaymentCubit>().setReceiptImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    if (state.receiptImage != null) {
      return Container(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          boxShadow: AppShadows.card,
        ),
        padding: EdgeInsets.all(Resources.horizontalDims.$16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Resources.radius.$r4),
              child: Image.file(
                File(state.receiptImage!.path),
                width: Resources.squareDims.$80,
                height: Resources.squareDims.$80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.receiptImage!.name,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryNavy,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  FutureBuilder<int>(
                    future: state.receiptImage!.length(),
                    builder: (context, snapshot) {
                      final sizeStr = snapshot.hasData
                          ? '${(snapshot.data! / (1024 * 1024)).toStringAsFixed(1)} MB'
                          : '...';
                      return Text(
                        sizeStr,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Resources.colors.luxuryBody,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () =>
                  context.read<MakePaymentCubit>().removeReceiptImage(),
              style: IconButton.styleFrom(
                backgroundColor: Resources.colors.luxuryError.withValues(
                  alpha: 0.1,
                ),
                foregroundColor: Resources.colors.luxuryError,
              ),
              icon: Icon(Icons.close, size: Resources.iconSizes.$18),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Resources.colors.luxuryBorder),
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          boxShadow: AppShadows.card,
        ),
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$24),
          child: Column(
            children: [
              Container(
                width: Resources.squareDims.$64,
                height: Resources.squareDims.$64,
                decoration: BoxDecoration(
                  color: Resources.colors.luxurySurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.upload_rounded,
                  size: Resources.iconSizes.$32,
                  color: Resources.colors.luxuryNavy.withValues(alpha: 0.4),
                ),
              ),
              SizedBox(height: Resources.verticalDims.$16),
              Text(
                loc.makePaymentTapToUploadReceipt,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Resources.colors.luxuryGoldLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
