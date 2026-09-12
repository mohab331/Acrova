import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_avatar_header.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/bottom_nav.dart';
import 'package:acrova/presentation/features/ui/shell/widgets/nav_tab.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  List<NavTab> _buildTabs(BuildContext context) {
    final loc = context.localization;
    return [
      NavTab(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: loc.navHome,
      ),
      NavTab(
        icon: Icons.folder_outlined,
        activeIcon: Icons.folder,
        label: loc.navProjects,
      ),
      NavTab(
        icon: Icons.account_balance_wallet_outlined,
        activeIcon: Icons.account_balance_wallet,
        label: loc.navPortfolio,
      ),
      NavTab(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: loc.navProfile,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.colors.luxuryBackground,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: Resources.horizontalDims.$20,
              end: Resources.horizontalDims.$20,
              top: Resources.verticalDims.$16,
            ),
            child: const AvatarHeader(),
          ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: BottomNav(
        tabs: _buildTabs(context),
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
