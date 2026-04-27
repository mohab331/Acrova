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
    super.key,
  });

  final Widget child;
  final Color? backGroundColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor ?? Resources.colors.luxuryBackground,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Directionality(
        textDirection: context.isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: Resources.horizontalDims.$20,
            end: Resources.horizontalDims.$20,
            top: Resources.verticalDims.$16,
            bottom: Resources.verticalDims.$32,
          ),
          child: child,
        ),
      ),
    );
  }
}
