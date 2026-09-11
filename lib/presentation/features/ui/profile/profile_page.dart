import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_avatar_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';
import 'package:acrova/presentation/features/cubit/profile/profile_cubit.dart';
import 'package:acrova/presentation/features/cubit/profile/profile_state.dart';
import 'package:acrova/presentation/features/ui/contact_us/contact_us_page.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/change_language_sheet.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_content.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _openEdit(UserProfileModel profile) async {
    final updated = await context.push<UserProfileModel>(
      AppRouteEnum.editProfilePage.path,
      extra: profile,
    );
    if (updated != null && mounted) {
      context.read<ProfileCubit>().setProfile(updated);
    }
  }

  Future<void> _logout() async {
    await context.read<AuthCubit>().clearAuthData();
    if (!mounted) return;
    context.read<AuthCubit>().resetToInitial();
    context.go(AppRouteEnum.welcomePage.path);
  }

  Future<void> _openLanguageSheet() async {
    final localizationCubit = context.read<LocalizationCubit>();
    final current = localizationCubit.currentLocale().languageCode;
    final selected = await ChangeLanguageSheet.show(context, current);
    if (selected == null || selected == current || !mounted) return;
    localizationCubit.updateLocale(Locale(selected));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.localization.changeLanguageSuccess),
        backgroundColor: Resources.colors.luxurySuccess,
      ),
    );
  }

  void _openContact({required String? email, required String? mobileNumber}) =>
      context.push(
        AppRouteEnum.contactUsPage.path,
        extra: ContactUsArgs(email: email, mobileNumber: mobileNumber),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<ProfileCubit>()..fetchProfile(),
      child: CommonScreen(
        bottomPadding: 0,
        child: BlocSelector<ProfileCubit, ProfileCubitState, ProfileCubitState>(
          selector: (state) => state,
          builder: (context, state) {
            return Column(
              children: [
                AvatarHeader(
                  userName: state.profile?.name ?? '',
                  notificationCount: 2,
                ),
                Flexible(
                  child: Builder(
                    builder: (context) {
                      if (state.isLoading ||
                          state.cubitStatus == CubitStatus.initial) {
                        return const ProfileSkeleton();
                      }
                      if (state.isError) {
                        return AppErrorState(
                          message:
                              state.appErrorModel?.message ??
                              context.localization.profileLoadError,
                          onRetry: () =>
                              context.read<ProfileCubit>().fetchProfile(),
                        );
                      }
                      final profile = state.profile;
                      if (profile == null) return const SizedBox.shrink();

                      return ProfileContent(
                        profile: profile,
                        onEdit: () => _openEdit(profile),
                        onLogout: _logout,
                        onLanguageTap: _openLanguageSheet,
                        onContactTap: () => _openContact(
                          email: profile.email,
                          mobileNumber: profile.mobileNumber,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
