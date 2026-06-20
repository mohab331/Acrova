import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Static placeholder box used inside [AppSkeletonLoader].
///
/// Wrap one or more [SkeletonBox] instances in [AppSkeletonLoader] to apply
/// the shared shimmer animation.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    required this.width,
    required this.height,
    this.radius,
    this.color,
    super.key,
  });

  final double width;
  final double height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Resources.colors.luxuryProgressTrack,
        borderRadius: BorderRadius.circular(radius ?? Resources.radius.$r4),
      ),
    );
  }
}
