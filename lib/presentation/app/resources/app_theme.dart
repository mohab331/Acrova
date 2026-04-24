part of 'resources.dart';

class _AppTheme {
  ThemeData lightTheme(String fontFamily) => ThemeData(
    fontFamily: Resources.fonts.ibmPlexSansArabic,
    useMaterial3: false,
    scaffoldBackgroundColor: Resources.colors.white,
    primaryColor: Resources.colors.primary,
  );
}
