part of 'resources.dart';

class _AppTheme {
  ThemeData lightTheme(Locale locale) {
    const colors   = _AppColors();
    final textTheme = _AppFonts.textTheme(locale);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: colors.luxuryBackground,
      textTheme: textTheme,
      colorScheme: ColorScheme.light(
        // primary = main action color (navy CTA buttons, headings)
        primary:          colors.luxuryNavy,
        onPrimary:        colors.white,
        // secondary = interactive accent (gold light — progress, links, borders)
        secondary:        colors.luxuryGold,
        onSecondary:      colors.luxuryInk,
        // surface = card / sheet backgrounds
        surface:          colors.luxurySurface,
        onSurface:        colors.luxuryBody,
        // background = scaffold
        surfaceContainerHighest: colors.luxuryBackground,
        // error
        error:            colors.luxuryError,
        onError:          colors.white,
      ),
    );
  }
}
