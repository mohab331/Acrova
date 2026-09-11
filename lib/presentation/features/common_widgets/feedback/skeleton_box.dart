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
    this.borderRadius,
    this.shape,
    super.key,
  });

  final double width;
  final double height;
  final double? radius;
  final Color? color;
  final BorderRadius? borderRadius;

  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: color ?? Resources.colors.luxuryProgressTrack,
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ??
                  BorderRadius.circular(radius ?? Resources.radius.$r4),
      ),
    );
  }
}
