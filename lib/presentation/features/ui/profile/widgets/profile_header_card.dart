import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    required this.profile,
    required this.onEdit,
    super.key,
  });

  final UserProfileModel profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return AppCard(
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      child: Column(
        children: [
          Container(
            width: Resources.squareDims.$80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Resources.colors.luxurySurface,
              border: Border.all(
                color: Resources.colors.luxuryGoldLight,
                width: AppBorderWidths.$2,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty
                ? AppCachedNetworkImage(imageUrl: profile.avatarUrl!)
                : Icon(
                    Icons.person_outline,
                    size: Resources.iconSizes.$40,
                    color: Resources.colors.luxuryPlaceholder,
                  ),
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Text(
            profile.name,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: Resources.fontSizes.$20,
              fontWeight: Resources.fontWeights.bold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            profile.email,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: Resources.fontSizes.$14,
              color: Resources.colors.luxuryBodyMuted,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Text(
            loc.memberSince,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: Resources.fontSizes.$12,
              color: Resources.colors.luxuryBody,
              letterSpacing: Resources.letterSpacing.$0_4,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onEdit,
              style: OutlinedButton.styleFrom(
                foregroundColor: Resources.colors.luxuryNavy,
                side: BorderSide(color: Resources.colors.luxuryBorder),
                padding: EdgeInsets.symmetric(
                  vertical: Resources.verticalDims.$12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Resources.radius.$r2),
                ),
              ),
              child: Text(
                loc.editProfile,
                style: TextStyle(
                  fontSize: Resources.fontSizes.$14,
                  fontWeight: Resources.fontWeights.semiBold,
                  letterSpacing: Resources.letterSpacing.$0_4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
