part of 'resources.dart';

/// Figma-extracted border/stroke width tokens.
/// All values are raw doubles (no screenutil scaling — border widths are not screen-density-dependent).
abstract final class AppBorderWidths {
  /// Thin border — card borders, dividers
  static const double $1 = 1.0;

  /// Medium border — focused input gold accent, avatar ring
  static const double $1_5 = 1.5;

  /// Thick border — OTP box focus, form field underline
  static const double $2 = 2.0;
}
