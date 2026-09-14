import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/utils/enums/user_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeContinueButton extends StatelessWidget {
  const WelcomeContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Resources.verticalDims.$55,
          width: double.infinity,
          child: AppPrimaryButton(
            onPressed: () =>
                context.pushReplacement(AppRouteEnum.phonePage.name),
            label: context.localization.cta.toUpperCase(),
          ),
        ),
        SizedBox(height: Resources.verticalDims.$12),
        TextButton(
          onPressed: () {
            context.read<AuthCubit>().setUserStatus(UserStatus.visitor);
            context.goTo(AppRouteEnum.homePage.name);
          },
          child: Text(context.localization.continueAsGuest),
        ),
      ],
    );
  }
}
