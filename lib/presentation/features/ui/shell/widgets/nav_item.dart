import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/nav_tab.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final NavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Resources.colors.luxuryGold
        : Resources.colors.luxuryPlaceholder;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isActive ? Resources.colors.luxuryGold : Colors.transparent,
              width: AppBorderWidths.$2,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: isActive ? 0 : 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? tab.activeIcon : tab.icon,
                color: color,
                size: Resources.iconSizes.$22,
              ),
              SizedBox(height: Resources.verticalDims.$2),
              Text(
                tab.label,
                style: TextStyle(
                  fontFamily: Resources.fonts.manrope,
                  fontSize: Resources.fontSizes.$8,
                  fontWeight: isActive
                      ? Resources.fontWeights.extraBold
                      : Resources.fontWeights.medium,
                  letterSpacing: Resources.letterSpacing.$0_8,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
