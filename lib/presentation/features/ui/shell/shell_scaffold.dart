import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ShellScaffold wraps the 4-tab bottom navigation shell.
///
/// Tabs:
///   0 → HOME       (/home)
///   1 → PROJECTS   (/projects)
///   2 → SUPPORT    (/support)
///   3 → PROFILE    (/profile)
class ShellScaffold extends StatelessWidget {
  const ShellScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    _NavTab(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'HOME'),
    _NavTab(
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder,
      label: 'PROJECTS',
    ),
    _NavTab(
      icon: Icons.account_balance_wallet_outlined,
      activeIcon: Icons.account_balance_wallet,
      label: 'PORTFOLIO',
    ),
    _NavTab(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'MESSAGES',
    ),
    _NavTab(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'PROFILE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.colors.luxuryBackground,
      body: navigationShell,
      bottomNavigationBar: _BottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        border: Border(
          top: BorderSide(
            color: Resources.colors.luxuryBorder,
            width: 1,
          ),
        ),
        boxShadow: AppShadows.float,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(
              ShellScaffold._tabs.length,
              (i) => Expanded(
                child: _NavItem(
                  tab: ShellScaffold._tabs[i],
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  final _NavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Resources.colors.luxuryGold      // gold when active
        : Resources.colors.luxuryPlaceholder;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          // Gold top-border indicator on active tab
          border: Border(
            top: BorderSide(
              color: isActive
                  ? Resources.colors.luxuryGold
                  : Colors.transparent,
              width: 2,
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
              const SizedBox(height: 2),
              // Label always visible — gold for active, muted for inactive
              Text(
                tab.label,
                style: TextStyle(
                  fontFamily: 'Manrope',
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

class _NavTab {
  const _NavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
