import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'app_theme.dart';
part 'colors.dart';
part 'dimens.dart';
part 'drawables.dart';
part 'elevations.dart';
part 'font_sizes.dart';
part 'font_weights.dart';
part 'app_fonts.dart';
part 'gradient_colors.dart';
part 'app_shadows.dart';
part 'letter_spacing.dart';
part 'radius.dart';

class Resources {
  const Resources._();
  static const _AppFonts fonts = _AppFonts();
  static const _AppColors colors = _AppColors();
  static const _AppDimens dimens = _AppDimens();
  static _AppTheme theme = _AppTheme();
  static const _AppDrawables drawables = _AppDrawables();
  static const _FontWeights fontWeights = _FontWeights();
  static const _LetterSpacing letterSpacing = _LetterSpacing();
  static const _Radius radius = _Radius();
  static const _Elevations elevation = _Elevations();
  static const _FontSizes fontSizes = _FontSizes();
  static const _HorizontalDimens horizontalDims = _HorizontalDimens();
  static const _VerticalDimens verticalDims = _VerticalDimens();
  static const _IconSizes iconSizes = _IconSizes();
  static const _AppGradientColors gradientColors = _AppGradientColors();
}
