import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class CommonScreen extends StatelessWidget {
  const CommonScreen({
    required this.child,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.backGroundColor,
    this.bottomPadding,
    this.padding,
    super.key,
  });

  final Widget child;
  final Color? backGroundColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  final PreferredSizeWidget? appBar;

  final double? bottomPadding;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor ?? Resources.colors.luxuryBackground,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Directionality(
        textDirection: context.isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding:
                padding ??
                EdgeInsetsDirectional.only(
                  start: Resources.horizontalDims.$20,
                  end: Resources.horizontalDims.$20,
                  top: Resources.verticalDims.$16,
                  bottom: bottomPadding ?? Resources.verticalDims.$32,
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
