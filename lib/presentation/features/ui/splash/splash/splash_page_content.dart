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
        ],
      ),
    );
  }
}
