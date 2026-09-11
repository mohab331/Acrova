import 'dart:async';

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class OtpCountdownTimer extends StatefulWidget {
  const OtpCountdownTimer({super.key});

  @override
  State<OtpCountdownTimer> createState() => _OtpCountdownTimerState();
}

class _OtpCountdownTimerState extends State<OtpCountdownTimer> {
  static const int _initialSeconds = 300;

  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = _initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remaining <= 0) {
        _timer?.cancel();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = _remaining ~/ 60;
    final s = _remaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          size: Resources.iconSizes.$16,
          color: Resources.colors.luxuryGold,
        ),
        SizedBox(width: Resources.horizontalDims.$4),
        Text(
          _formattedTime,
          style: context.textTheme.labelLarge?.copyWith(
            letterSpacing: Resources.letterSpacing.$n0_9,
            color: _remaining > 60
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryError,
          ),
        ),
      ],
    );
  }
}
