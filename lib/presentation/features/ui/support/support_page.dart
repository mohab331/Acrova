import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Support / Revisions tab — stub for future Phase 7 implementation.
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Resources.colors.luxuryBackground,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.headset_mic_outlined,
                  size: Resources.iconSizes.$64,
                  color: Resources.colors.luxuryGoldLight,
                ),
                SizedBox(height: Resources.verticalDims.$20),
                Text(
                  context.localization.supportAndRevisionsTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Resources.colors.luxuryNavy,
                      ),
                ),
                SizedBox(height: Resources.verticalDims.$8),
                Text(
                  context.localization.supportComingSoonPhase7,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
