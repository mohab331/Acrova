import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/otp_countdown_timer.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class OtpTimerSection extends StatelessWidget {
  const OtpTimerSection({required this.duration, super.key});

  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.localization.timeRemaining.toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: Resources.fontWeights.semiBold,
            letterSpacing: Resources.letterSpacing.$1_0,
            color: Resources.colors.luxuryGoldLight,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        OtpCountdownTimer(timer: duration),
      ],
    );
  }
}
