part of 'resources.dart';

/// Figma-extracted shadow tokens. All values are const — use as BoxDecoration.boxShadow.
abstract final class AppShadows {
  /// Subtle card lift (1px blur, 1px y-offset)
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];

  /// Primary CTA button shadow (navy @ 10%)
  static const List<BoxShadow> cta = [
    BoxShadow(
      color: Color(0x1A000615),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  /// Hero dark card shadow (black @ 10%)
  static const List<BoxShadow> hero = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 25,
      spreadRadius: -5,
      offset: Offset(0, 20),
    ),
  ];

  /// Gallery / image card shadow
  static const List<BoxShadow> image = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 6,
      spreadRadius: -1,
      offset: Offset(0, 4),
    ),
  ];

  /// Gold accent button glow (luxuryGoldLight @ 20%)
  static const List<BoxShadow> goldButton = [
    BoxShadow(
      color: Color(0x33C8A96A),
      blurRadius: 15,
      spreadRadius: -3,
      offset: Offset(0, 10),
    ),
  ];

  /// Floating action / bottom sheet handle shadow
  static const List<BoxShadow> float = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      spreadRadius: -4,
      offset: Offset(0, 8),
    ),
  ];

  /// Featured project card elevated shadow
  static const List<BoxShadow> featuredCard = [
    BoxShadow(
      color: Color(0x0A191C1D),
      blurRadius: 32,
      offset: Offset(0, 4),
    ),
  ];

  /// Content panel / bottom sheet lift shadow (luxuryInk @ 8%)
  static const List<BoxShadow> sheet = [
    BoxShadow(
      color: Color(0x14000615),
      blurRadius: 30,
      offset: Offset(0, -8),
    ),
  ];
}
