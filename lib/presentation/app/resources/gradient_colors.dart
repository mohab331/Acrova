part of 'resources.dart';

/// Public gradient constants — mirrors the pattern of [AppShadows].
///
/// These are ink-overlay gradients used over hero images and cards.
/// All values are const — use directly in BoxDecoration.gradient.
abstract final class AppGradients {
  /// Portfolio hero card — top label scrim (90% → 40% → 0%)
  static const List<Color> heroCardOverlay = [
    Color(0xE6000615), // luxuryInk @ 90%
    Color(0x66000615), // luxuryInk @ 40%
    Color(0x00000615), // luxuryInk @ 0%
  ];

  /// Portfolio grid card — denser top scrim (80% → 20% → 0%)
  static const List<Color> gridCardOverlay = [
    Color(0xCC000615), // luxuryInk @ 80%
    Color(0x33000615), // luxuryInk @ 20%
    Color(0x00000615), // luxuryInk @ 0%
  ];

  /// Detail page header scrim — back-button legibility (60% → 0%)
  static const List<Color> detailHeaderScrim = [
    Color(0x99000615), // luxuryInk @ 60%
    Color(0x00000615), // luxuryInk @ 0%
  ];

  /// Dashboard / gallery design card — bottom label overlay (0% → 72%)
  static const List<Color> designCardOverlay = [
    Color(0x00000000), // transparent
    Color(0xB8000615), // luxuryInk @ 72%
  ];
}

class _AppGradientColors {
  const _AppGradientColors();

  /// Dark navy fade for hero card overlays
  static const List<Color> heroNavyFade = [
    Color(0xFF0B1F3A),
    Color(0x800B1F3A),
    Color(0x000B1F3A),
  ];

  /// Gold shimmer for premium accent elements
  static const List<Color> goldShimmer = [
    Color(0xFFC8A96A),
    Color(0xFFE8D5A3),
    Color(0xFFC8A96A),
  ];

  /// Skeleton loader shimmer (light grey wave)
  static const List<Color> skeletonShimmer = [
    Color(0xFFE7E8E9),
    Color(0xFFF3F4F5),
    Color(0xFFE7E8E9),
  ];

  /// Welcome screen background top-to-bottom subtle fade
  static const List<Color> backgroundFade = [
    Color(0xFFF8F9FA),
    Color(0xFFEDEEEF),
  ];

}
