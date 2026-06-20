import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/nav_item.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/nav_tab.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<NavTab> tabs;
  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        border: Border(
          top: BorderSide(color: Resources.colors.luxuryBorder),
        ),
        boxShadow: AppShadows.float,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: Resources.verticalDims.$60,
          child: Row(
            children: List.generate(
              tabs.length,
              (i) => Expanded(
                child: NavItem(
                  tab: tabs[i],
                  isActive: currentIndex == i,
                  onTap: () => onTap(i),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
