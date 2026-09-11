import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_state.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_form.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileSubmitButton extends StatelessWidget {
  const EditProfileSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$16,
          vertical: Resources.verticalDims.$24,
        ),
        decoration: BoxDecoration(
          color: Resources.colors.luxurySurface,
          border: Border(
            top: BorderSide(color: Resources.colors.luxuryBorder),
          ),
        ),
        child: SafeArea(
      top: false,
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        buildWhen: (p, c) => p.isSubmitting != c.isSubmitting,
        builder: (context, state) {
          return AppPrimaryButton(
            label: context.localization.editProfileSubmit,
            isLoading: state.isSubmitting,
            onPressed: () => context.read<EditProfileCubit>().submit(
                  resolve: (code) => resolveEditProfileError(context, code),
                ),
          );
        },
      ),
    ));
  }
}
