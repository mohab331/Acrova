import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/formatters/app_formatter.dart';
import 'package:flutter/material.dart';

class AmountDueCard extends StatelessWidget {
  const AmountDueCard({super.key, this.quote});

  final PaymentQuoteModel? quote;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final currency = quote?.currency;
    final amountDue = quote != null
        ? AppFormatter.formatAmount(quote!.amountDue)
        : '-';
    final baseFee = quote != null
        ? AppFormatter.formatAmount(quote!.baseFee)
        : '-';
    final vat = quote != null ? AppFormatter.formatAmount(quote!.vat) : '-';
    final total = quote != null ? AppFormatter.formatAmount(quote!.total) : '-';

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
