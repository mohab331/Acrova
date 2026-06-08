part of 'resources.dart';

class _AppColors {
  const _AppColors();

  // ── Base ────────────────────────────────────────────────────────────────────
  final Color white = const Color(0xFFFFFFFF);

  // ── Backgrounds ─────────────────────────────────────────────────────────────
  /// Screen / scaffold background
  final Color luxuryBackground = const Color(0xFFF8F9FA);

  /// Card / surface background
  final Color luxurySurface = const Color(0xFFFFFFFF);

  /// OTP boxes / input fills
  final Color luxuryInputBg = const Color(0xFFF3F4F5);

  // ── Primary palette ─────────────────────────────────────────────────────────
  /// Deepest text, logo background
  final Color luxuryInk = const Color(0xFF000615);

  /// Primary CTA button, hero card bg, section headings
  final Color luxuryNavy = const Color(0xFF0B1F3A);

  /// Display heading accent — ONLY for typography (e.g. "Future Home" word)
  final Color luxuryGold = const Color(0xFF735B24);

  /// ALL interactive accents: progress bars, links, borders, icons, OTP timer
  final Color luxuryGoldLight = const Color(0xFF735B24);

  /// Gold text overlaying dark backgrounds/images
  final Color luxuryGoldOnDark = const Color(0xFFFFDF9F);

  // ── Text ────────────────────────────────────────────────────────────────────
  /// Body text, subtitles
  final Color luxuryBody = const Color(0xFF44474D);

  /// Secondary / muted body text
  final Color luxuryBodyMuted = const Color(0x70444D4D);  // rgba(68,71,77,0.7)

  /// Input placeholder text
  final Color luxuryPlaceholder = const Color(0xFFC4C6CE);

  // ── Borders ─────────────────────────────────────────────────────────────────
  /// Card borders, dividers
  final Color luxuryBorder = const Color(0xFFEDEEEF);

  /// OTP box borders
  final Color luxuryInputBorder = const Color(0x4DC4C6CE);  // rgba(196,198,206,0.3)

  /// Profile badge border (gold @ 20%)
  final Color luxuryGoldBorder = const Color(0x33C8A96A);  // rgba(200,169,106,0.2)

  /// Phone input bottom-only border
  final Color luxuryGoldBottomBorder = const Color(0xFFC8A96A);

  // ── Progress ────────────────────────────────────────────────────────────────
  /// Progress bar background track
  final Color luxuryProgressTrack = const Color(0xFFE7E8E9);

  // ── Semantic ────────────────────────────────────────────────────────────────
  final Color luxuryError   = const Color(0xFFC0392B);
  final Color luxurySuccess = const Color(0xFF1A7A4A);
  final Color luxuryWarning = const Color(0xFFD4850A);
}
