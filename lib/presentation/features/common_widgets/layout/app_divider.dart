import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Thin horizontal divider using luxuryBorder colour.
///
/// Design token: luxuryBorder (#EDEEEF), 1px height.
class AppDivider extends StatelessWidget {
  const AppDivider({
    this.height = 1,
    this.indent = 0,
    this.endIndent = 0,
    super.key,
  });

  final double height;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: height,
      indent: indent,
      endIndent: endIndent,
      color: Resources.colors.luxuryBorder,
    );
  }
}
