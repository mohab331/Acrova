import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Top floating banner shown when the form has validation errors.
class EditProfileErrorBanner extends StatelessWidget {
  const EditProfileErrorBanner({required this.onDismiss, super.key});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(
          color: Resources.colors.luxuryError.withValues(alpha: 0.3),
        ),
        boxShadow: AppShadows.float,
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Resources.colors.luxuryError,
            size: Resources.iconSizes.$20,
          ),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Text(
              context.localization.editProfileBannerError,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: Resources.fontSizes.$13,
                fontWeight: Resources.fontWeights.medium,
                color: Resources.colors.luxuryInk,
              ),
            ),
          ),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(
              Icons.close,
              color: Resources.colors.luxuryBodyMuted,
              size: Resources.iconSizes.$20,
            ),
          ),
        ],
      ),
    );
  }
}
