import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_logo/app_logo.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/auth/welcome/widgets/welcome_continue_button.dart';
import 'package:acrova/presentation/features/ui/auth/welcome/widgets/welcome_title_subtitle_widget.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return CommonScreen(
      child: Column(
        children: [
          SizedBox(height: Resources.verticalDims.$70),
          const AppLogo(),
          SizedBox(height: Resources.verticalDims.$95),
          const WelcomeTitleSubtitleWidget(),
          const Spacer(),
          const WelcomeContinueButton(),
          SizedBox(height: Resources.verticalDims.$32),
          Text(
            localization.footer,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: Resources.colors.luxuryBody,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$32),
        ],
      ),
    );
  }
}
