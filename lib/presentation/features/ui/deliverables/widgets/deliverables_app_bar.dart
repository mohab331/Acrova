import 'dart:ui';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeliverablesAppBar extends StatelessWidget {
  const DeliverablesAppBar({
    this.projectName = '',
    this.thumbnailUrl,
    super.key,
  });

  final String projectName;
  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Resources.colors.luxurySurface.withValues(alpha: 0.8),
            padding: EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$24,
              vertical: Resources.verticalDims.$16,
            ).copyWith(top: MediaQuery.paddingOf(context).top + Resources.verticalDims.$16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Resources.colors.luxuryNavy,
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.deliverablesTitle,
                          style: context.textTheme.titleLarge?.copyWith(
                            color: Resources.colors.luxuryNavy,
                            fontWeight: Resources.fontWeights.bold,
                          ),
                        ),
                        if (projectName.isNotEmpty)
                          Text(
                            projectName.toUpperCase(),
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Resources.colors.luxuryBodyMuted,
                              letterSpacing: Resources.letterSpacing.$2,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: Resources.squareDims.$40,
                  height: Resources.squareDims.$40,
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryInputBg,
                    borderRadius: BorderRadius.circular(Resources.radius.$r4),
                    image: thumbnailUrl != null && thumbnailUrl!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(thumbnailUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: thumbnailUrl == null || thumbnailUrl!.isEmpty
                      ? Icon(
                          Icons.apartment,
                          color: Resources.colors.luxuryGoldLight,
                          size: Resources.fontSizes.$20,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
