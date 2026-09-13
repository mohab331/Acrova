import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class PaymentGridItem extends StatelessWidget {
  const PaymentGridItem({required this.label, required this.value});

  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label?.isNotEmpty ?? false)
          Text(
            label ?? '',
            style: context.textTheme.labelSmall?.copyWith(
              color: Resources.colors.luxuryBody,
              letterSpacing: 1.5,
              fontWeight: Resources.fontWeights.semiBold,
            ),
          ),
        if (value?.isNotEmpty ?? false) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            value ?? '',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
        ],
      ],
    );
  }
}
