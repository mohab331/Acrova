import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable filter chip used in Projects and Portfolio screens.
class FiltersChip extends StatelessWidget {
  const FiltersChip({
    required this.label,
    required this.active,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$22,
          vertical: Resources.verticalDims.$6,
        ),
        decoration: BoxDecoration(
          color: active
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxuryInputBg,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: active
              ? null
              : Border.all(color: Resources.colors.luxuryBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: Resources.fontSizes.$12,
            fontWeight: Resources.fontWeights.semiBold,
            color: active
                ? Resources.colors.white
                : Resources.colors.luxuryBody,
          ),
        ),
      ),
    );
  }
}
