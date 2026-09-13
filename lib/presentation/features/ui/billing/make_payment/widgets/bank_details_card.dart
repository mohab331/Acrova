import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankDetailsCard extends StatelessWidget {
  const BankDetailsCard({this.quote});

  final PaymentQuoteModel? quote;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final bankName = quote?.bankName?.isNotEmpty == true
        ? quote!.bankName
        : loc.bankNameDefault;
    final iban = quote?.iban?.isNotEmpty == true ? quote!.iban : '-';
    final accountName = quote?.accountName?.isNotEmpty == true
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
            value: bankName ?? '',
            hasCopy: false,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          _BankInfoItem(label: loc.makePaymentIban, value: iban ?? ''),
          SizedBox(height: Resources.verticalDims.$16),
          _BankInfoItem(
            label: loc.makePaymentAccountName,
            value: accountName ?? '',
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
        if (hasCopy && value != '-')
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
