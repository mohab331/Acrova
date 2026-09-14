import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/inputs/app_filled_field.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.nationalIDController,
    required this.isMobileReadOnly,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController nationalIDController;
  final bool isMobileReadOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final cubit = context.read<EditProfileCubit>();

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            AppFilledField(
              controller: nameController,
              label: l10n.editProfileNameLabel,
              validator: AppValidators.name,
              keyboardType: TextInputType.name,
              onChanged: cubit.updateName,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            AppFilledField(
              controller: mobileController,
              label: l10n.editProfileMobileLabel,
              hint: l10n.editProfileMobileHint,
              readOnly: isMobileReadOnly,
              validator: isMobileReadOnly ? null : AppValidators.saudiPhone,
              keyboardType: TextInputType.phone,
              onChanged: isMobileReadOnly ? null : cubit.updateMobile,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            AppFilledField(
              controller: emailController,
              label: l10n.editProfileEmailLabel,
              validator: AppValidators.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: cubit.updateEmail,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            AppFilledField(
              controller: nationalIDController,
              label: l10n.profileSetupNationalIdLabel,
              validator: AppValidators.saudiNationalId,
              keyboardType: TextInputType.number,
              onChanged: cubit.updateNationalID,
            ),
          ],
        );
      },
    );
  }
}
