import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

class WelcomeContinueButton extends StatelessWidget {
  const WelcomeContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.verticalDims.$55,
      width: double.infinity,
      child: AppPrimaryButton(
        onPressed: () => context.pushReplacement(AppRouteEnum.phonePage.name),
        label: context.localization.cta.toUpperCase(),
      ),
    );
  }
}
