import 'package:flutter/material.dart';

class DashboardQuickAction {
  const DashboardQuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
