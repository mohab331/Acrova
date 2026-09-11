import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DetailMetaDot extends StatelessWidget {
  const DetailMetaDot({required this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    if(text?.isEmpty ?? true) return const SizedBox.shrink();
    return Text(
      text ?? '',
      style: context.textTheme.labelMedium?.copyWith(
        fontSize: Resources.fontSizes.$11,
        fontWeight: Resources.fontWeights.medium,
        color: Resources.colors.luxuryBodyMuted,
      ),
    );
  }
}
