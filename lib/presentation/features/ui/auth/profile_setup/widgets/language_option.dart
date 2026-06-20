import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class LanguageOption extends StatelessWidget {
  const LanguageOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final String selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () => onTap(value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$12),
        decoration: BoxDecoration(
          color: isSelected
              ? Resources.colors.luxurySurface
              : Resources.colors.luxuryProgressTrack,
          borderRadius: BorderRadius.circular(Resources.radius.$r2),
          border: Border.all(
            color: isSelected
                ? Resources.colors.luxuryBorder
                : Colors.transparent,
          ),
          boxShadow: isSelected ? AppShadows.card : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.language,
              size: Resources.iconSizes.$16,
              color: isSelected
                  ? Resources.colors.luxuryGold
                  : Resources.colors.luxuryBody,
            ),
            SizedBox(width: Resources.horizontalDims.$6),
            Text(
              label,
              style: TextStyle(
                fontFamily: Resources.fonts.manrope,
                fontSize: Resources.fontSizes.$14,
                fontWeight: isSelected
                    ? Resources.fontWeights.semiBold
                    : Resources.fontWeights.regular,
                color: isSelected
                    ? Resources.colors.luxuryInk
                    : Resources.colors.luxuryBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
