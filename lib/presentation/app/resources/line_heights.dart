part of 'resources.dart';

/// Text line-height multiplier tokens.
/// These are pure scalar values (not scaled by ScreenUtil) — use as TextStyle.height.
class _AppLineHeights {
  const _AppLineHeights();

  /// Tight — heading display text (headlineSmall, titleLarge)
  double get $1_2 => 1.2;

  /// Snug — card titles, NotoSerif callouts
  double get $1_25 => 1.25;

  /// Base compact — welcome screen subtitles
  double get $1_3 => 1.3;

  /// Normal — hero banner headings
  double get $1_4 => 1.4;

  /// Relaxed — description paragraphs, terms text
  double get $1_5 => 1.5;

  /// Loose — narrative body, long-form content
  double get $1_6 => 1.6;
}
