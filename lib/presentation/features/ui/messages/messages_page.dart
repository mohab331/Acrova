import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Messages tab — stub for future Phase implementation.
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: Resources.colors.luxuryGoldLight,
                ),
                const SizedBox(height: 20),
                Text(
                  'Messages',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Resources.colors.luxuryNavy,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Coming soon',
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
