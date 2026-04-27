import 'dart:math' as math;

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_logo/app_logo.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/auth/welcome/widgets/welcome_title_subtitle_widget.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/primary_button_theme_X.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          _ContinueButton(),
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

class _ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.verticalDims.$55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: context.theme.primaryButtonStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.localization.cta.toUpperCase(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: Resources.colors.white,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Icon(Icons.arrow_forward, size: Resources.iconSizes.$20),
          ],
        ),
      ),
    );
  }
}
