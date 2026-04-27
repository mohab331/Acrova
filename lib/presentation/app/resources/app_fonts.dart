part of 'resources.dart';

class _AppFonts {
  const _AppFonts();
  static TextTheme textTheme(Locale locale) {
    final isAr = locale.languageCode == 'ar';

    final primaryFont = isAr ? 'IBMPlexArabic' : 'Manrope';
    final headingFont = isAr ? 'IBMPlexArabic' : 'NotoSerif';

    final base = ThemeData.light().textTheme;

    return base.copyWith(
      displayLarge: _style(
        headingFont,
        AppTextTokens.displayXL,
        FontWeight.w700,
        isAr,
      ),
      displayMedium: _style(
        headingFont,
        AppTextTokens.displayL,
        FontWeight.w600,
        isAr,
      ),
      displaySmall: _style(
        headingFont,
        AppTextTokens.displayM,
        FontWeight.w600,
        isAr,
      ),

      titleLarge: _style(
        headingFont,
        AppTextTokens.titleL,
        FontWeight.w600,
        isAr,
      ),
      titleMedium: _style(
        primaryFont,
        AppTextTokens.titleM,
        FontWeight.w600,
        isAr,
      ),

      bodyLarge: _style(
        primaryFont,
        AppTextTokens.bodyL,
        FontWeight.w400,
        isAr,
      ),
      bodyMedium: _style(
        primaryFont,
        AppTextTokens.bodyM,
        FontWeight.w400,
        isAr,
      ),
      bodySmall: _style(
        primaryFont,
        AppTextTokens.bodyS,
        FontWeight.w400,
        isAr,
      ),

      labelLarge: _style(
        primaryFont,
        AppTextTokens.labelL,
        FontWeight.w600,
        isAr,
      ),
      labelMedium: _style(
        primaryFont,
        AppTextTokens.labelM,
        FontWeight.w500,
        isAr,
      ),
    );
  }

  static TextStyle _style(
    String font,
    double size,
    FontWeight weight,
    bool isAr,
  ) {
    return TextStyle(
      fontFamily: font,
      fontSize: size,
      fontWeight: weight,
      height: _lineHeight(size, isAr),
      letterSpacing: isAr ? 0 : _letterSpacing(size),
    );
  }

  static double _lineHeight(double size, bool isAr) {
    if (size >= 28) return isAr ? 1.4 : 1.25;
    if (size >= 16) return isAr ? 1.6 : 1.35;
    return isAr ? 1.5 : 1.3;
  }

  static double _letterSpacing(double size) {
    if (size >= 28) return 0.2;
    if (size >= 16) return 0.15;
    return 0.1;
  }
}

class AppTextTokens {
  static const displayXL = 40.0;
  static const displayL = 34.0;
  static const displayM = 28.0;
  static const titleL = 22.0;
  static const titleM = 18.0;
  static const bodyL = 16.0;
  static const bodyM = 14.0;
  static const bodyS = 12.0;
  static const labelL = 14.0;
  static const labelM = 12.0;
}
