import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentListItem extends StatelessWidget {
  const PaymentListItem({
    required this.payment,
    required this.onTap,
    super.key,
  });

  final PaymentModel payment;
  final VoidCallback onTap;

  IconData _getIcon() {
    switch (payment.status) {
      case PaymentStatus.success:
        return Icons.check_circle_outline;
      case PaymentStatus.rejected:
        return Icons.error_outline;
      case PaymentStatus.pending:
        return Icons.schedule;
    }
  }

  Color _getIconColor() {
    switch (payment.status) {
      case PaymentStatus.success:
        return Resources.colors.luxurySuccess;
      case PaymentStatus.rejected:
        return Resources.colors.luxuryError;
      case PaymentStatus.pending:
        return Resources.colors.luxuryWarning;
    }
  }

  Color _getIconBgColor() {
    return _getIconColor().withValues(alpha: 0.1);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy').format(payment.date);
    final formattedAmount = NumberFormat('#,##0').format(payment.amount);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Resources.horizontalDims.$16),
        decoration: BoxDecoration(
          color: Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: Border.all(color: Resources.colors.luxuryBorder),
          boxShadow: [
            BoxShadow(
              color: Resources.colors.luxuryInk.withValues(alpha: 0.03),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getIconBgColor(),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(),
                color: _getIconColor(),
                size: 20,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.projectName,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: Resources.fontWeights.semiBold,
                      color: Resources.colors.luxuryNavy,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    formattedDate,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Resources.colors.luxuryBody,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${payment.currency} $formattedAmount',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  payment.status.localizedName(context),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: _getIconColor(),
                    fontWeight: Resources.fontWeights.semiBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
