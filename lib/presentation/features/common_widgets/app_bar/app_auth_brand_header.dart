import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/constants/app_constants.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAuthBrandHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AppAuthBrandHeader({
    this.showBack = false,
    this.label = AppConstants.appName,
    this.onBack,
    this.centerTitle = true,
    this.fontSize,
    super.key,
  });

  final bool showBack;
  final VoidCallback? onBack;

  final String label;

  final bool centerTitle;

  final double? fontSize;
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + Resources.verticalDims.$20);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Resources.horizontalDims.$16,
        end: Resources.horizontalDims.$16,
        top: Resources.verticalDims.$20,
        bottom: Resources.verticalDims.$20,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: context.textTheme.titleMedium?.copyWith(
          fontSize: fontSize ?? Resources.fontSizes.$24,
          color: Resources.colors.luxuryInk,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: centerTitle,
        title: Text(label),
        leading: showBack ? CustomBackButton(onBack: onBack) : null,
        leadingWidth: Resources.horizontalDims.$40,
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Resources.colors.luxuryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        side: BorderSide(color: Resources.colors.luxuryBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        onTap: onBack ?? () => context.pop(),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: Resources.iconSizes.$16,
          color: Resources.colors.luxuryNavy,
        ),
      ),
    );
  }
}
