part of 'resources.dart';

/// Exact font sizes (px) from Figma — do not alter without updating Figma first.
abstract final class AppTextTokens {
  // ── Display / Heading ──────────────────────────────────────────────────────
  static const double displayL = 57.0;
  static const double displayM = 45.0;
  static const double displayS = 36.0;

  static const double headlineL = 32.0;
  static const double headlineM = 28.0;
  static const double headlineS = 24.0;

  // ── Brand / Section ────────────────────────────────────────────────────────
  static const double brandMark =
      20.0; // NotoSerif 400, lh 28, ls +6, UPPERCASE
  static const double sectionTitle = 20.0; // NotoSerif 700, lh 28, ls -0.5
  static const double cardTitle = 16.0; // NotoSerif 700, lh 24
  static const double galleryTitle = 16.0; // NotoSerif 600, lh 24

  // ── Titles ─────────────────────────────────────────────────────────────────
  /// TextTheme.titleLarge  → NotoSerif 700, 20px
  static const double titleL = 22.0;

  /// TextTheme.titleMedium → NotoSerif 700, 16px (card title)
  static const double titleM = 16.0;

  /// TextTheme.titleSmall  → Manrope 300, 18px (welcome subtitle)
  static const double titleS = 14.0;

  // ── Body ───────────────────────────────────────────────────────────────────
  static const double bodyL = 16.0;
  static const double bodyM = 14.0;
  static const double bodyS = 12.0;

  // ── Labels / Captions ─────────────────────────────────────────────────────
  static const double caption = 12.0;
  static const double labelL = 14.0;
  static const double labelM = 12.0;
  static const double labelS = 11.0;

  // ── Special ────────────────────────────────────────────────────────────────
  static const double otpDigit = 24.0;
  static const double timer = 36.0;
  static const double buttonPrimary = 14.0;
  static const double buttonSecondary = 16.0;
}

class _AppFonts {
  const _AppFonts();

  // ── Font Family Constants ───────────────────────────────────────────────────
  /// Body / label font (English + fallback)
  final String manrope = 'Manrope';

  /// Heading / display font (English)
  final String notoSerif = 'NotoSerif';

  /// Body + heading font (Arabic)
  final String ibmPlexArabic = 'IBMPlexArabic';

  /// Builds the full [TextTheme] from Figma tokens, locale-aware.
  static TextTheme textTheme(Locale locale) {
    final bool isAr = locale.languageCode == 'ar';
    final String body = isAr ? 'IBMPlexArabic' : 'Manrope';
    final String heading = isAr ? 'IBMPlexArabic' : 'NotoSerif';

    return ThemeData.light().textTheme.copyWith(
      displayLarge: _ts(
        family: heading,
        size: AppTextTokens.displayL,
        weight: FontWeight.w400,
        height: 60 / 48,
        letterSpacing: isAr ? 0 : -1.2,
      ),
      displayMedium: _ts(
        family: heading,
        size: AppTextTokens.displayL,
        weight: FontWeight.w400,
        height: 50 / 40,
      ),
      displaySmall: _ts(
        family: heading,
        size: AppTextTokens.displayM,
        weight: FontWeight.w400,
        height: 40 / 32,
      ),

      headlineLarge: _ts(
        family: heading,
        size: AppTextTokens.headlineL,
        weight: FontWeight.w400,
        height: 40 / 32,
      ),
      headlineMedium: _ts(
        family: heading,
        size: AppTextTokens.headlineM,
        weight: FontWeight.w400,
        height: 40 / 32,
      ),
      headlineSmall: _ts(
        family: heading,
        size: AppTextTokens.headlineS,
        weight: FontWeight.w400,
        height: 40 / 32,
      ),

      titleLarge: _ts(
        family: heading,
        size: AppTextTokens.titleL,
        weight: FontWeight.w500,
        height: 28 / 20,
        letterSpacing: isAr ? 0 : -0.5,
      ),

      titleMedium: _ts(
        family: heading,
        size: AppTextTokens.titleM,
        weight: FontWeight.w500,
        height: 24 / 16,
      ),

      titleSmall: _ts(
        family: body,
        size: AppTextTokens.titleS,
        weight: FontWeight.w500,
        height: 29.25 / 18,
      ),

      bodyLarge: _ts(
        family: body,
        size: AppTextTokens.bodyL,
        weight: FontWeight.w400,
        height: 1.24,
        letterSpacing: 0.15
      ),

      bodyMedium: _ts(
        family: body,
        size: AppTextTokens.bodyM,
        weight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0.25,
      ),

      bodySmall: _ts(
        family: body,
        size: AppTextTokens.bodyS,
        weight: FontWeight.w400,
        height: 1.16,
        letterSpacing: 0.4
      ),

      labelLarge: _ts(
        family: body,
        size: AppTextTokens.labelL,
        weight: FontWeight.w500,
        height: 1.2,
        letterSpacing: isAr ? 0 : 0.1,
      ),

      labelMedium: _ts(
        family: body,
        size: AppTextTokens.labelM,
        weight: FontWeight.w500,
        height: 1.16,
        letterSpacing: isAr ? 0 : 0.5,
      ),

      labelSmall: _ts(
        family: body,

        size: AppTextTokens.labelS,
        weight: FontWeight.w500,
        height: 1.16,
        letterSpacing: isAr ? 0 : 0.5,
      ),
    );
  }

  static TextStyle _ts({
    required String family,
    required double size,
    required FontWeight weight,
    required double height,
    double letterSpacing = 0,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
