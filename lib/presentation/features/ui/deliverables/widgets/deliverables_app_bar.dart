import 'dart:ui';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeliverablesAppBar extends StatelessWidget {
  const DeliverablesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                          'Deliverables',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: Resources.colors.luxuryNavy,
                            fontWeight: Resources.fontWeights.bold,
                          ),
                        ),
                        Text(
                          'AL-RIYADH ESTATE',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Resources.colors.luxuryBodyMuted,
                            letterSpacing: 2,
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
                    image: const DecorationImage(
                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDcGhS7dgMqJyGsUYUAFQExELBOQbqLumY8IdMLgJDLS--7jcOcTmv8ts_0VffCmk1BgD9M9_109gUDRf8Ec0Z4XPMDBS-9fqhJ-yGi9eDT9W-6Ski7NFoQzkk8N3q-wFbxOPRtToq3MUJY9g-ZJigw8vkSyrrYwl3oRpQ7u67Q_6TlfBUiScEDw8yT_SJMTGVTEtIhMm_EYr7Y-FTfpCYJpNVtFFfWgDcABqdFqly6xm1p_w8gB35c'),
                      fit: BoxFit.cover,
                    ),
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
