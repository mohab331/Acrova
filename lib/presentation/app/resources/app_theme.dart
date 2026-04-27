part of 'resources.dart';

class _AppTheme {
  ThemeData lightTheme(Locale locale) {
    final textTheme = _AppFonts.textTheme(locale);
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const _AppColors().luxuryBackground,
      textTheme: textTheme,
      colorScheme: ColorScheme.dark(
        primary: const _AppColors().luxuryGold,
        surface: const _AppColors().luxuryNavy,
      ),
    );
  }
}
