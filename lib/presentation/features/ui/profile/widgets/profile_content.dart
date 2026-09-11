import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_header_card.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_logout_button.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_menu_item.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_section.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_stats_row.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    required this.profile,
    required this.onEdit,
    required this.onLogout,
    required this.onLanguageTap,
    required this.onContactTap,
    super.key,
  });

  final UserProfileModel profile;
  final VoidCallback onEdit;
  final VoidCallback onLogout;
  final VoidCallback onLanguageTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final isAr = profile.language == 'ar';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileHeaderCard(profile: profile, onEdit: onEdit),
          SizedBox(height: Resources.verticalDims.$24),
          ProfileStatsRow(
            projectsCount: profile.projectsCount,
            completedCount: profile.completedCount,
          ),
          SizedBox(height: Resources.verticalDims.$24),
          ProfileSection(
            title: loc.preferences,
            items: [
              ProfileMenuItem(
                icon: Icons.language_outlined,
                label: loc.language,
                trailing: Text(
                  isAr ? loc.languageArabic : loc.languageEnglish,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: Resources.fontSizes.$12,
                    color: Resources.colors.luxuryBodyMuted,
                  ),
                ),
                onTap: onLanguageTap,
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$20),
          ProfileSection(
            title: loc.helpAndSupport,
            items: [
              ProfileMenuItem(
                icon: Icons.contact_support_outlined,
                label: loc.contactSupport,
                onTap: onContactTap,
              ),
              ProfileMenuItem(
                icon: Icons.description_outlined,
                label: loc.termsAndPrivacy,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$24),
          ProfileLogoutButton(onLogout: onLogout),
          SizedBox(height: Resources.verticalDims.$32),
        ],
      ),
    );
  }
}
