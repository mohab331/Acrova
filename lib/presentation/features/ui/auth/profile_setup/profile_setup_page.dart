import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/inputs/app_ghost_field.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/cubit/profile_completion_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/cubit/profile_completion_state.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/enter_acrova_button.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/language_selector.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_field_label.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/change_photo_sheet.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_photo_section.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({this.args, super.key});

  final ProfileCompletionArgs? args;

  @override
  Widget build(BuildContext context) {
    final authPhone = context.read<AuthCubit>().state.phoneNumber;
    final currentLang = context.locale.languageCode;

    return BlocProvider(
      create: (_) => ProfileCompletionCubit(
        authRepo: serviceLocatorInstance<BaseAuthRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
        initialPhone: authPhone,
        initialLanguage: currentLang,
      ),
      child: _ProfileSetupView(args: args),
    );
  }
}

class _ProfileSetupView extends StatefulWidget {
  const _ProfileSetupView({this.args});

  final ProfileCompletionArgs? args;

  @override
  State<_ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<_ProfileSetupView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _nationalIdController;

  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _nationalIdError;

  @override
  void initState() {
    super.initState();
    final initialState = context.read<ProfileCompletionCubit>().state;
    _nameController = TextEditingController(text: initialState.name);
    _emailController = TextEditingController(text: initialState.email);
    _mobileController = TextEditingController(text: initialState.mobileNumber);
    _nationalIdController =
        TextEditingController(text: initialState.nationalId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  Future<void> _onChangePhoto(BuildContext context) async {
    final cubit = context.read<ProfileCompletionCubit>();
    final action = await PickFromSheet.show(context);
    switch (action) {
      case ChangePhotoAction.camera:
        await cubit.pickAvatarFromCamera();
      case ChangePhotoAction.library:
        await cubit.pickAvatarFromGallery();
      case ChangePhotoAction.remove:
        cubit.removeAvatar();
      case null:
        break;
    }
  }

  bool _validate(BuildContext context) {
    final l10n = context.localization;
    String? nameErr;
    String? emailErr;
    String? mobileErr;
    String? idErr;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final mobile = _mobileController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    if (name.isEmpty) {
      nameErr = l10n.profileSetupNameRequired;
    } else if (AppValidators.name(name) != null) {
      nameErr = AppValidators.name(name);
    }

    if (email.isEmpty) {
      emailErr = l10n.profileSetupEmailRequired;
    } else if (!AppValidators.isValidEmail(email)) {
      emailErr = l10n.profileSetupEmailInvalid;
    }

    if (mobile.isEmpty) {
      mobileErr = l10n.profileSetupMobileRequired;
    } else if (!AppValidators.isValidSaudiPhone(mobile) &&
        !AppValidators.isValidPhone(mobile)) {
      mobileErr = l10n.profileSetupMobileInvalid;
    }

    if (nationalId.isEmpty) {
      idErr = l10n.profileSetupNationalIdRequired;
    } else if (AppValidators.saudiNationalId(nationalId) != null) {
      idErr = l10n.profileSetupNationalIdInvalid;
    }

    setState(() {
      _nameError = nameErr;
      _emailError = emailErr;
      _mobileError = mobileErr;
      _nationalIdError = idErr;
    });

    return nameErr == null &&
        emailErr == null &&
        mobileErr == null &&
        idErr == null;
  }

  void _submit(BuildContext context) {
    if (!_validate(context)) return;
    context.read<ProfileCompletionCubit>().submit();
  }

  void _handleStateListener(
    BuildContext context,
    ProfileCompletionState state,
  ) {
    if (state.isSuccess) {
      CustomToastification.success(
        context: context,
        message: context.localization.profileSetupSuccess,
      ).showToast();

      // Refresh AuthCubit with updated user profile
      context.read<AuthCubit>().getUser();

      if (widget.args?.returnRoute != null &&
          widget.args!.returnRoute!.isNotEmpty) {
        context.goTo(widget.args!.returnRoute!);
      } else {
        context.pop(true);
      }
    } else if (state.isError) {
      CustomToastification.error(
        context: context,
        errorModel: state.appErrorModel,
      ).showToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<ProfileCompletionCubit, ProfileCompletionState>(
      listener: _handleStateListener,
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
                child: BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
                  buildWhen: (p, c) => p.avatarPath != c.avatarPath,
                  builder: (context, state) {
                    return EditProfilePhotoSection(
                      avatarPath: state.avatarPath,
                      onChangePhoto: () => _onChangePhoto(context),
                    );
                  },
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
                onChanged: (val) {
                  context.read<ProfileCompletionCubit>().updateName(val);
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
                onChanged: (val) {
                  context.read<ProfileCompletionCubit>().updateEmail(val);
                  if (_emailError != null) setState(() => _emailError = null);
                },
              ),
              SizedBox(height: Resources.verticalDims.$20),
              AppGhostField(
                controller: _mobileController,
                label: l10n.profileSetupMobileLabel,
                hint: l10n.profileSetupMobileHint,
                error: _mobileError,
                keyboardType: TextInputType.phone,
                onChanged: (val) {
                  context.read<ProfileCompletionCubit>().updateMobile(val);
                  if (_mobileError != null) setState(() => _mobileError = null);
                },
              ),
              SizedBox(height: Resources.verticalDims.$20),
              AppGhostField(
                controller: _nationalIdController,
                label: l10n.profileSetupNationalIdLabel,
                hint: l10n.profileSetupNationalIdHint,
                error: _nationalIdError,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  context.read<ProfileCompletionCubit>().updateNationalId(val);
                  if (_nationalIdError != null) {
                    setState(() => _nationalIdError = null);
                  }
                },
              ),
              SizedBox(height: Resources.verticalDims.$24),
              ProfileFieldLabel(label: l10n.profileSetupLanguageLabel),
              SizedBox(height: Resources.verticalDims.$12),
              BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
                buildWhen: (p, c) => p.language != c.language,
                builder: (context, state) {
                  return LanguageSelector(
                    selected: state.language,
                    onChanged: (lang) => context
                        .read<ProfileCompletionCubit>()
                        .updateLanguage(lang),
                  );
                },
              ),
              SizedBox(height: Resources.verticalDims.$32),
              BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
                buildWhen: (p, c) => p.cubitStatus != c.cubitStatus,
                builder: (context, state) {
                  return EnterAcrovaButton(
                    isLoading: state.isLoading,
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
