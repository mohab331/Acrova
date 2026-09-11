import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/inputs/app_ghost_field.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/enter_acrova_button.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/language_selector.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_field_label.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_photo_section.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
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

  String? _nameError;
  String? _emailError;
  String? _nationalIdError;

  String _language = 'en';
  String? _avatarPath;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = serviceLocatorInstance<BaseImagePickerService>();
    final file = await picker.pickFromGallery();
    if (file != null && mounted) setState(() => _avatarPath = file.path);
  }

  bool _validate(BuildContext context) {
    final l10n = context.localization;
    String? nameErr;
    String? emailErr;
    String? idErr;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    if (name.isEmpty) nameErr = l10n.profileSetupNameRequired;
    if (email.isEmpty) {
      emailErr = l10n.profileSetupEmailRequired;
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      emailErr = l10n.profileSetupEmailInvalid;
    }
    if (nationalId.isEmpty) idErr = l10n.profileSetupNationalIdRequired;

    setState(() {
      _nameError = nameErr;
      _emailError = emailErr;
      _nationalIdError = idErr;
    });
    return nameErr == null && emailErr == null && idErr == null;
  }

  void _submit(BuildContext context) {
    if (!_validate(context)) return;
    context.read<AuthCubit>().saveProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      nationalId: _nationalIdController.text.trim(),
      language: _language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<AuthCubit, AuthCubitState>(
      listenWhen: (p, c) => p.cubitStatus != c.cubitStatus,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.profileSetupTitle,
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
                style: TextStyle(
                  fontFamily: Resources.fonts.manrope,
                  fontSize: Resources.fontSizes.$14,
                  color: Resources.colors.luxuryBody,
                  height: Resources.lineHeights.$1_5,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$28),
              Center(
                child: EditProfilePhotoSection(
                  avatarPath: _avatarPath,
                  onChangePhoto: _pickPhoto,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              AppGhostField(
                controller: _nameController,
                label: l10n.profileSetupNameLabel,
                hint: l10n.profileSetupNameHint,
                error: _nameError,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) {
                  if (_nameError != null) setState(() => _nameError = null);
                },
              ),
              SizedBox(height: Resources.verticalDims.$20),
              AppGhostField(
                controller: _emailController,
                label: l10n.profileSetupEmailLabel,
                hint: l10n.profileSetupEmailHint,
                error: _emailError,
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) {
                  if (_emailError != null) setState(() => _emailError = null);
                },
              ),
              SizedBox(height: Resources.verticalDims.$20),
              AppGhostField(
                controller: _nationalIdController,
                label: l10n.profileSetupNationalIdLabel,
                hint: l10n.profileSetupNationalIdHint,
                error: _nationalIdError,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  if (_nationalIdError != null) {
                    setState(() => _nationalIdError = null);
                  }
                },
              ),
              SizedBox(height: Resources.verticalDims.$24),
              ProfileFieldLabel(label: l10n.profileSetupLanguageLabel),
              SizedBox(height: Resources.verticalDims.$12),
              LanguageSelector(
                selected: _language,
                onChanged: (lang) => setState(() => _language = lang),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              BlocBuilder<AuthCubit, AuthCubitState>(
                buildWhen: (p, c) => p.cubitStatus != c.cubitStatus,
                builder: (context, state) {
                  return EnterAcrovaButton(
                    isLoading: state.cubitStatus == CubitStatus.loading,
                    onPressed: () => _submit(context),
                  );
                },
              ),
              SizedBox(height: Resources.verticalDims.$32),
            ],
          ),
        ),
      ),
    );
  }
}
