import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_app_bar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Standard app bar — back arrow + centered NotoSerif title + optional actions.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    this.title,
    this.titleWidget,
    this.actions,
    this.backgroundColor,
    this.leading,
    this.showBack = true,
    this.onBackPressed,
    this.brightness = Brightness.light,
    super.key,
  }) : assert(
          title != null || titleWidget != null || !showBack,
          'Provide title or titleWidget when showBack is true',
        );

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? leading;
  final bool showBack;
  final VoidCallback? onBackPressed;
  final Brightness brightness;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Resources.colors.luxuryBackground;
    final iconColor = brightness == Brightness.light
        ? Resources.colors.luxuryNavy
        : Resources.colors.white;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: bg,
      systemOverlayStyle: brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading: showBack
          ? (leading ??
              AppAppBarBackButton(
                color: iconColor,
                onPressed: onBackPressed ??
                    () => Navigator.of(context).maybePop(),
              ))
          : leading,
      centerTitle: true,
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Resources.colors.luxuryNavy,
                      ),
                )
              : null),
      actions: actions,
    );
  }
}
