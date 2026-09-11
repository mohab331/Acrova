import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_app_bar.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/edit_profile_form.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      title: context.localization.editProfileTitle,
      actions: [
        TextButton(
          onPressed: () => context.read<EditProfileCubit>().submit(
                resolve: (code) => resolveEditProfileError(context, code),
              ),
          child: Text(
            context.localization.editProfileSave.toUpperCase(),
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$14,
              fontWeight: Resources.fontWeights.semiBold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryGold,
            ),
          ),
        ),
      ],
    );
  }
}
