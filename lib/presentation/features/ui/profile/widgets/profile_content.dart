import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/change_language_sheet.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_header_card.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_logout_button.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_menu_item.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_section.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_stats_row.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({required this.profile, super.key});

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return RefreshIndicator(
      onRefresh: () => context.read<AuthCubit>().getUser(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileHeaderCard(
              profile: profile,
              onEdit: () => _openEdit(context, profile),
            ),
            SizedBox(height: Resources.verticalDims.$24),
            ProfileStatsRow(
              projectsCount: profile.projectsCount ?? 0,
              completedCount: profile.completedCount ?? 0,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            ProfileSection(
              title: loc.preferences,
              items: [
                ProfileMenuItem(
                  icon: Icons.language_outlined,
                  label: loc.language,
                  trailing: Text(
                    context.locale.languageCode,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: Resources.fontSizes.$12,
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                  onTap: () => _openLanguageSheet(context),
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
                  onTap: () => _openContact(
                    context,
                    email: profile.email,
                    mobileNumber: profile.mobileNumber,
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.description_outlined,
                  label: loc.termsAndPrivacy,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: Resources.verticalDims.$24),
            const ProfileLogoutButton(),
            SizedBox(height: Resources.verticalDims.$32),
          ],
        ),
      ),
    );
  }

  void _openEdit(BuildContext context, UserProfileModel profile) {
    context.push(
      AppRouteEnum.editProfilePage.name,
      extra: EditProfileArgs(profile: profile),
    );
  }

  Future<void> _openLanguageSheet(BuildContext context) async {
    final localizationCubit = context.read<LocalizationCubit>();
    final current = localizationCubit.currentLocale().languageCode;
    final selected = await ChangeLanguageSheet.show(context, current);
    if (selected == null || selected == current || !context.mounted) return;
    localizationCubit.updateLocale(Locale(selected));
  }

  void _openContact(
    BuildContext context, {
    required String? email,
    required String? mobileNumber,
  }) => context.push(
    AppRouteEnum.contactUsPage.name,
    extra: ContactUsArgs(email: email, mobileNumber: mobileNumber),
  );
}
