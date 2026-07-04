import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Drag handle indicator shown at the top of a bottom sheet.
class AppSheetHandle extends StatelessWidget {
  const AppSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Resources.horizontalDims.$48,
        height: Resources.verticalDims.$4,
        margin: EdgeInsets.symmetric(vertical: Resources.verticalDims.$12),
        decoration: BoxDecoration(
          color: Resources.colors.luxuryInputBorder,
          borderRadius: BorderRadius.circular(Resources.radius.$r100),
        ),
      ),
    );
  }
}
