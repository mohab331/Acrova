import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_avatar_header.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_menu_item.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_section.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return CommonScreen(
      bottomPadding: 0,
      child: Column(
        children: [
          const AvatarHeader(userName: 'Mohab', notificationCount: 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppCard(
                    padding: EdgeInsets.all(Resources.horizontalDims.$24),
                    child: Column(
                      children: [
                        Container(
                          width: Resources.squareDims.$80,
                          height: Resources.squareDims.$80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Resources.colors.luxurySurface,
                            border: Border.all(
                              color: Resources.colors.luxuryGoldLight,
                              width: AppBorderWidths.$2,
                            ),
                          ),
                          child: const Center(
                            child: AppCachedNetworkImage(
                              imageUrl:
                                  'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
                            ),
                          ),
                        ),
                        SizedBox(height: Resources.verticalDims.$16),
                        Text(
                          loc.mockUserName,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontSize: Resources.fontSizes.$20,
                            fontWeight: Resources.fontWeights.bold,
                            color: Resources.colors.luxuryNavy,
                          ),
                        ),
                        SizedBox(height: Resources.verticalDims.$8),
                        Text(
                          loc.mockUserEmail,
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
                            onPressed: () {},
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
                  ),
                  SizedBox(height: Resources.verticalDims.$24),
                  Row(
                    children: [
                      Expanded(
                        child: AppCard(
                          padding: EdgeInsets.all(Resources.horizontalDims.$16),
                          child: Column(
                            children: [
                              Text(
                                '8',
                                style: TextStyle(
                                  fontSize: Resources.fontSizes.$26,
                                  fontWeight: Resources.fontWeights.bold,
                                  color: Resources.colors.luxuryGoldLight,
                                ),
                              ),
                              SizedBox(height: Resources.verticalDims.$4),
                              Text(
                                loc.projects,
                                style: TextStyle(
                                  fontSize: Resources.fontSizes.$12,
                                  color: Resources.colors.luxuryBodyMuted,
                                  letterSpacing: Resources.letterSpacing.$0_4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: Resources.horizontalDims.$12),
                      Expanded(
                        child: AppCard(
                          padding: EdgeInsets.all(Resources.horizontalDims.$16),
                          child: Column(
                            children: [
                              Text(
                                '3',
                                style: TextStyle(
                                  fontSize: Resources.fontSizes.$26,
                                  fontWeight: Resources.fontWeights.bold,
                                  color: Resources.colors.luxurySuccess,
                                ),
                              ),
                              SizedBox(height: Resources.verticalDims.$4),
                              Text(
                                loc.completed,
                                style: TextStyle(
                                  fontSize: Resources.fontSizes.$12,
                                  color: Resources.colors.luxuryBodyMuted,
                                  letterSpacing: Resources.letterSpacing.$0_4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$24),
                  ProfileSection(
                    title: loc.account,
                    items: [
                      ProfileMenuItem(icon: Icons.lock_outline, label: loc.changePassword, onTap: () {}),
                      ProfileMenuItem(icon: Icons.receipt_long_outlined, label: loc.billingHistory, onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  ProfileSection(
                    title: loc.preferences,
                    items: [
                      ProfileMenuItem(
                        icon: Icons.language_outlined,
                        label: loc.language,
                        trailing: Text(
                          loc.profileSetupLanguageEn,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$12,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ProfileMenuItem(icon: Icons.notifications_outlined, label: loc.notifications, onTap: () {}),
                      ProfileMenuItem(icon: Icons.privacy_tip_outlined, label: loc.privacySettings, onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  ProfileSection(
                    title: loc.helpAndSupport,
                    items: [
                      ProfileMenuItem(icon: Icons.help_outline, label: loc.helpCenter, onTap: () {}),
                      ProfileMenuItem(icon: Icons.contact_support_outlined, label: loc.contactSupport, onTap: () {}),
                      ProfileMenuItem(icon: Icons.description_outlined, label: loc.termsAndPrivacy, onTap: () {}),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Resources.colors.luxuryError,
                        side: BorderSide(color: Resources.colors.luxuryError),
                        padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Resources.radius.$r2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_outlined, size: Resources.iconSizes.$16),
                          SizedBox(width: Resources.horizontalDims.$8),
                          Text(
                            loc.logout,
                            style: TextStyle(
                              fontSize: Resources.fontSizes.$14,
                              fontWeight: Resources.fontWeights.semiBold,
                              letterSpacing: Resources.letterSpacing.$0_4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
