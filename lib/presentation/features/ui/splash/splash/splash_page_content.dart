import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_logo/app_logo.dart';
import 'package:flutter/material.dart';

class SplashPageContent extends StatelessWidget {
  const SplashPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppLogo(),
          SizedBox(height: Resources.verticalDims.$16),
          Text(
            'ACROVA',
            style: TextStyle(
              fontFamily: Resources.fonts.notoSerif,
              fontSize: Resources.fontSizes.$20,
              fontWeight: Resources.fontWeights.regular,
              letterSpacing: Resources.letterSpacing.$6_0,
              color: Resources.colors.luxuryNavy,
              height: 28 / 20,
            ),
          ),
        ],
      ),
    );
  }
}
