import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: Image.asset(
        Resources.drawables.appLogoPNG,
        width: Resources.horizontalDims.$100,
        color: Resources.colors.luxuryNavy,
      ),
    );
  }
}
