import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class AppAppBarBackButton extends StatelessWidget {
  const AppAppBarBackButton({
    required this.color,
    this.onPressed,
    super.key,
  });

  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: color,
        size: Resources.iconSizes.$16,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }
}
