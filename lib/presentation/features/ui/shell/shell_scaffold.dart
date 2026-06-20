import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/bottom_nav.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/nav_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    NavTab(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'HOME'),
    NavTab(icon: Icons.folder_outlined, activeIcon: Icons.folder, label: 'PROJECTS'),
    NavTab(icon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet, label: 'PORTFOLIO'),
    NavTab(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'MESSAGES'),
    NavTab(icon: Icons.person_outline, activeIcon: Icons.person, label: 'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.colors.luxuryBackground,
      body: navigationShell,
      bottomNavigationBar: BottomNav(
        tabs: _tabs,
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
