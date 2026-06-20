import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSpecCell extends StatelessWidget {
  const DetailSpecCell({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$16, vertical: Resources.verticalDims.$12),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r4),
        border: Border.all(
          color: Resources.colors.luxuryPlaceholder.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryBody,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$2),
          Text(
            value,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: Resources.fontSizes.$12,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
