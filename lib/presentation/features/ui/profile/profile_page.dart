import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/dashboard/dashboard_page.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile tab — displays user profile, settings, and account management.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      child: Column(
        children: [
          AvatarHeader(userName: 'Mohab', notificationCount: 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Text(
                    'Manage your personal information, preferences, projects, and account settings in one seamless experience.',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppCard(
                    padding: EdgeInsets.all(Resources.horizontalDims.$24),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Resources.colors.luxurySurface,
                            border: Border.all(
                              color: Resources.colors.luxuryGoldLight,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: AppCachedNetworkImage(
                              imageUrl: 'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
                            ),
                          ),
                        ),

                        SizedBox(height: Resources.verticalDims.$16),

                        // Name
                        Text(
                          'Mohab Osama',
                          style: context.textTheme.labelLarge?.copyWith(
                            fontSize: Resources.fontSizes.$20,
                            fontWeight: Resources.fontWeights.bold,
                            color: Resources.colors.luxuryNavy,
                          ),
                        ),

                        SizedBox(height: Resources.verticalDims.$8),

                        // Email
                        Text(
                          'mohabosama787@gmail.com',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: Resources.fontSizes.$14,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                        ),

                        SizedBox(height: Resources.verticalDims.$16),

                        // Member since
                        Text(
                          context.localization.memberSince,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$12,
                            color: Resources.colors.luxuryBody,
                            letterSpacing: Resources.letterSpacing.$0_4,
                          ),
                        ),

                        SizedBox(height: Resources.verticalDims.$20),

                        // Edit profile button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Resources.colors.luxuryNavy,
                              side: BorderSide(
                                color: Resources.colors.luxuryBorder,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: Resources.verticalDims.$12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Resources.radius.$r2,
                                ),
                              ),
                            ),
                            child: Text(
                              context.localization.editProfile,
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

                  // ── Statistics section ──────────────────────────────────────
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
                                context.localization.projects,
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
                                context.localization.completed,
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

                  // ── Account section ────────────────────────────────────────
                  _ProfileSection(
                    title: context.localization.account,
                    items: [
                      _ProfileMenuItem(
                        icon: Icons.lock_outline,
                        label: context.localization.changePassword,
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.receipt_long_outlined,
                        label: context.localization.billingHistory,
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: Resources.verticalDims.$20),

                  // ── Preferences section ─────────────────────────────────────
                  _ProfileSection(
                    title: context.localization.preferences,
                    items: [
                      _ProfileMenuItem(
                        icon: Icons.language_outlined,
                        label: context.localization.language,
                        trailing: Text(
                          context.localization.profileSetupLanguageEn,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$12,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                        ),
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        label: context.localization.notifications,
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.privacy_tip_outlined,
                        label: context.localization.privacySettings,
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: Resources.verticalDims.$20),

                  // ── Support section ────────────────────────────────────────
                  _ProfileSection(
                    title: context.localization.helpAndSupport,
                    items: [
                      _ProfileMenuItem(
                        icon: Icons.help_outline,
                        label: context.localization.helpCenter,
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.contact_support_outlined,
                        label: context.localization.contactSupport,
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.description_outlined,
                        label: context.localization.termsAndPrivacy,
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: Resources.verticalDims.$24),

                  // ── Logout button ───────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Resources.colors.luxuryError,
                        side: BorderSide(color: Resources.colors.luxuryError),
                        padding: EdgeInsets.symmetric(
                          vertical: Resources.verticalDims.$14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Resources.radius.$r2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            size: Resources.iconSizes.$16,
                          ),
                          SizedBox(width: Resources.horizontalDims.$8),
                          Text(
                            context.localization.logout,
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

// ─── Profile Section ─────────────────────────────────────────────────────────

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.title, required this.items});

  final String title;
  final List<_ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.bold,
            letterSpacing: Resources.letterSpacing.$1_0,
            color: Resources.colors.luxuryBody,
          ),
        ),
        SizedBox(height: 8.h,),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;
              return Column(
                children: [
                  GestureDetector(
                    onTap: item.onTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Resources.horizontalDims.$16,
                        vertical: Resources.verticalDims.$16,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: Resources.iconSizes.$20,
                            color: Resources.colors.luxuryNavy,
                          ),
                          SizedBox(width: Resources.horizontalDims.$12),
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: Resources.fontSizes.$14,
                                color: Resources.colors.luxuryInk,
                              ),
                            ),
                          ),
                          if (item.trailing != null) ...[
                            SizedBox(width: Resources.horizontalDims.$12),
                            item.trailing!,
                          ] else ...[
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: Resources.iconSizes.$14,
                              color: Resources.colors.luxuryBorder,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: Resources.colors.luxuryBorder,
                      indent: Resources.horizontalDims.$16,
                      endIndent: Resources.horizontalDims.$16,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ─── Menu Item ───────────────────────────────────────────────────────────────

class _ProfileMenuItem {
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
}
