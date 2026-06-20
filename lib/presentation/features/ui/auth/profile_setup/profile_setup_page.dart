import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/enter_acrova_button.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/language_selector.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/luxury_icon_text_field.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_card.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_field_label.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_page_footer.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_terms_text.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  String _selectedLanguage = 'en';

  String? _nameError;
  String? _emailError;
  String? _nationalIdError;

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _nationalIdFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _nationalIdFocus.dispose();
    super.dispose();
  }

  bool _validate(BuildContext context) {
    final l10n = context.localization;
    String? nameErr;
    String? emailErr;
    String? nationalIdErr;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    if (name.isEmpty) nameErr = l10n.profileSetupNameRequired;
    if (email.isEmpty) {
      emailErr = l10n.profileSetupEmailRequired;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      emailErr = l10n.profileSetupEmailInvalid;
    }
    if (nationalId.isEmpty) nationalIdErr = l10n.profileSetupNationalIdRequired;

    setState(() {
      _nameError = nameErr;
      _emailError = emailErr;
      _nationalIdError = nationalIdErr;
    });

    return nameErr == null && emailErr == null && nationalIdErr == null;
  }

  void _submit(BuildContext context) {
    if (!_validate(context)) return;
    context.read<AuthCubit>().saveProfile(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          nationalId: _nationalIdController.text.trim(),
          language: _selectedLanguage,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<AuthCubit, AuthCubitState>(
      listenWhen: (prev, curr) => prev.cubitStatus != curr.cubitStatus,
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacement(AppRouteEnum.homePage.name);
        } else if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.appErrorModel?.message ?? ''),
              backgroundColor: Resources.colors.luxuryError,
            ),
          );
        }
      },
      child: CommonScreen(
        resizeToAvoidBottomInset: true,
        bottomPadding: 0,
        appBar: const AppAuthBrandHeader(showBack: true),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Resources.verticalDims.$20),
              ProfileCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.profileSetupTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Resources.fonts.notoSerif,
                        fontSize: Resources.fontSizes.$24,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryInk,
                        letterSpacing: Resources.letterSpacing.$n0_6,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$8),
                    Text(
                      l10n.profileSetupDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Resources.fonts.manrope,
                        fontSize: Resources.fontSizes.$14,
                        color: Resources.colors.luxuryBody,
                        height: Resources.lineHeights.$1_5,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$28),
                    ProfileFieldLabel(label: l10n.profileSetupNameLabel),
                    SizedBox(height: Resources.verticalDims.$6),
                    LuxuryIconTextField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      nextFocus: _emailFocus,
                      hint: l10n.profileSetupNameHint,
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      error: _nameError,
                      onChanged: (_) {
                        if (_nameError != null) setState(() => _nameError = null);
                      },
                    ),
                    SizedBox(height: Resources.verticalDims.$20),
                    ProfileFieldLabel(label: l10n.profileSetupEmailLabel),
                    SizedBox(height: Resources.verticalDims.$6),
                    LuxuryIconTextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _nationalIdFocus,
                      hint: l10n.profileSetupEmailHint,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      error: _emailError,
                      onChanged: (_) {
                        if (_emailError != null) setState(() => _emailError = null);
                      },
                    ),
                    SizedBox(height: Resources.verticalDims.$20),
                    ProfileFieldLabel(label: l10n.profileSetupNationalIdLabel),
                    SizedBox(height: Resources.verticalDims.$6),
                    LuxuryIconTextField(
                      controller: _nationalIdController,
                      focusNode: _nationalIdFocus,
                      hint: l10n.profileSetupNationalIdHint,
                      icon: Icons.badge_outlined,
                      error: _nationalIdError,
                      onChanged: (_) {
                        if (_nationalIdError != null) setState(() => _nationalIdError = null);
                      },
                    ),
                    SizedBox(height: Resources.verticalDims.$24),
                    ProfileFieldLabel(label: l10n.profileSetupLanguageLabel),
                    SizedBox(height: Resources.verticalDims.$12),
                    LanguageSelector(
                      selected: _selectedLanguage,
                      onChanged: (lang) => setState(() => _selectedLanguage = lang),
                    ),
                    SizedBox(height: Resources.verticalDims.$28),
                    BlocBuilder<AuthCubit, AuthCubitState>(
                      builder: (context, state) => EnterAcrovaButton(
                        isLoading: state.isLoading,
                        onPressed: () => _submit(context),
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$20),
                    const ProfileTermsText(),
                  ],
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              const ProfilePageFooter(),
              SizedBox(height: Resources.verticalDims.$16),
            ],
          ),
        ),
      ),
    );
  }
}
