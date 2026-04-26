import 'dart:math' as math;

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return Scaffold(
      backgroundColor: Resources.colors.luxuryBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Resources.horizontalDims.$32,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: math.max(44.h, constraints.maxHeight * .09),
                    ),
                    const _BrandMark(),
                    SizedBox(
                      height: math.max(72.h, constraints.maxHeight * .10),
                    ),
                    _HeroCopy(
                      titlePrefix: localization.welcomeTitlePrefix,
                      titleHighlight: localization.welcomeTitleHighlight,
                      titleSuffix: localization.welcomeTitleSuffix,
                      subtitle: localization.welcomeSubtitle,
                    ),
                    SizedBox(
                      height: math.max(84.h, constraints.maxHeight * .12),
                    ),
                    _ContinueButton(label: localization.welcomeContinueButton),
                    SizedBox(
                      height: math.max(64.h, constraints.maxHeight * .09),
                    ),
                    Text(
                      localization.welcomeFooter,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Resources.colors.luxuryBody,
                        fontFamily: Resources.fonts.ibmPlexSans,
                        fontSize: Resources.fontSizes.$12,
                        fontWeight: Resources.fontWeights.regular,
                        height: 16 / 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64.r,
          width: 64.r,
          color: Resources.colors.luxuryInk,
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size(18.r, 26.r),
            painter: _ArcovaMarkPainter(color: Resources.colors.white),
          ),
        ),
        SizedBox(height: Resources.verticalDims.$24),
        Text(
          'ARCOVA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Resources.colors.luxuryInk,
            fontFamily: 'serif',
            fontSize: Resources.fontSizes.$20,
            fontWeight: Resources.fontWeights.regular,
            height: 28 / 20,
            letterSpacing: 6,
          ),
        ),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.titlePrefix,
    required this.titleHighlight,
    required this.titleSuffix,
    required this.subtitle,
  });

  final String titlePrefix;
  final String titleHighlight;
  final String titleSuffix;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: Resources.colors.luxuryInk,
      fontFamily: 'serif',
      fontSize: 48.sp,
      fontWeight: Resources.fontWeights.regular,
      height: 60 / 48,
      letterSpacing: 0,
    );

    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$titlePrefix\n'),
              TextSpan(
                text: '$titleHighlight\n',
                style: titleStyle.copyWith(color: Resources.colors.luxuryGold),
              ),
              TextSpan(
                text: titleSuffix,
                style: titleStyle.copyWith(color: Resources.colors.luxuryGold),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: titleStyle,
        ),
        SizedBox(height: Resources.verticalDims.$24),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Resources.colors.luxuryBody,
              fontFamily: Resources.fonts.ibmPlexSans,
              fontSize: Resources.fontSizes.$18,
              fontWeight: Resources.fontWeights.regular,
              height: 29.25 / 18,
              letterSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Resources.colors.luxuryInk.withValues(alpha: .18),
          backgroundColor: Resources.colors.luxuryNavy,
          foregroundColor: Resources.colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: Resources.fonts.ibmPlexSans,
                fontSize: Resources.fontSizes.$14,
                fontWeight: Resources.fontWeights.regular,
                height: 20 / 14,
                letterSpacing: 1.4,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Icon(Icons.arrow_forward, size: Resources.iconSizes.$20),
          ],
        ),
      ),
    );
  }
}

class _ArcovaMarkPainter extends CustomPainter {
  const _ArcovaMarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height * .28);
    canvas.drawCircle(center, size.width * .12, paint);
    canvas.drawLine(
      Offset(size.width * .5, size.height * .42),
      Offset(size.width * .18, size.height * .96),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * .5, size.height * .42),
      Offset(size.width * .82, size.height * .96),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * .5, size.height * .06),
      Offset(size.width * .5, size.height * .16),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcovaMarkPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
