import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.notifications_outlined,
            color: Resources.colors.luxuryInk,
            size: Resources.iconSizes.$24,
          ),
        ),
        if (count > 0)
          Positioned(
            top: -4,
            right: -0.2,
            child: Container(
              width: Resources.squareDims.$16,
              height: Resources.squareDims.$16,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryError,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: TextStyle(
                    fontFamily: Resources.fonts.manrope,
                    fontSize: Resources.fontSizes.$8,
                    fontWeight: Resources.fontWeights.extraBold,
                    color: Resources.colors.luxurySurface,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
