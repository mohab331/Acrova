part of 'resources.dart';

/// Grid and card aspect-ratio tokens.
/// Use in SliverGridDelegate, AspectRatio widgets, and GridView builders.
abstract final class AppAspectRatios {
  /// 1:1 square — portfolio grid cards, avatar placeholders
  static const double square = 1.0;

  /// 2.4:1 wide — toggle feature cards (requirements step), spec grid cells
  static const double card2x4 = 2.4;

  /// 2.8:1 wide — dashboard quick-action 2×2 grid cards
  static const double quickAction = 2.8;
}
