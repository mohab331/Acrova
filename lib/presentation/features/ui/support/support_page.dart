import 'package:acrova/presentation/app/resources/resources.dart';
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
                  size: 64,
                  color: Resources.colors.luxuryGoldLight,
                ),
                const SizedBox(height: 20),
                Text(
                  'Support & Revisions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Resources.colors.luxuryNavy,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Coming soon in Phase 7',
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
