import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/inputs/app_filled_field.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final cubit = context.read<EditProfileCubit>();

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (p, c) =>
          p.nameError != c.nameError ||
          p.emailError != c.emailError ||
          p.mobileError != c.mobileError,
      builder: (context, state) {
        return Column(
          children: [
            AppFilledField(
              controller: nameController,
              label: l10n.editProfileNameLabel,
              error: state.nameError,
              keyboardType: TextInputType.name,
              onChanged: cubit.updateName,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            AppFilledField(
              controller: mobileController,
              label: l10n.editProfileMobileLabel,
              hint: l10n.editProfileMobileHint,
              error: state.mobileError,
              keyboardType: TextInputType.phone,
              onChanged: cubit.updateMobile,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            AppFilledField(
              controller: emailController,
              label: l10n.editProfileEmailLabel,
              error: state.emailError,
              keyboardType: TextInputType.emailAddress,
              onChanged: cubit.updateEmail,
            ),
          ],
        );
      },
    );
  }
}

/// Maps a validation error code to its localized message.
String resolveEditProfileError(BuildContext context, EditProfileFieldError code) {
  final l10n = context.localization;
  return switch (code) {
    EditProfileFieldError.nameRequired => l10n.editProfileNameRequired,
    EditProfileFieldError.emailRequired => l10n.editProfileEmailRequired,
    EditProfileFieldError.emailInvalid => l10n.editProfileEmailInvalid,
    EditProfileFieldError.mobileInvalid => l10n.editProfileMobileInvalid,
  };
}
