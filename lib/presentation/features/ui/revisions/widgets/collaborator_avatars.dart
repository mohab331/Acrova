import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Stacked square badges of collaborator initials (e.g. FA / MK).
class CollaboratorAvatars extends StatelessWidget {
  const CollaboratorAvatars({required this.initials, super.key});

  final List<String> initials;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.squareDims.$25,
      child: Stack(
        children: [
          for (int i = 0; i < initials.length; i++)
            Positioned(
              left: i * Resources.horizontalDims.$20,
              child: _Badge(text: initials[i]),
            ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Resources.squareDims.$25,
      height: Resources.squareDims.$25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Resources.colors.luxuryProgressTrack,
        borderRadius: BorderRadius.circular(Resources.radius.$r20),
        border: Border.all(color: Resources.colors.luxurySurface),
      ),
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: Resources.fontSizes.$10,
          fontWeight: Resources.fontWeights.bold,
          color: Resources.colors.luxuryBody,
        ),
      ),
    );
  }
}
