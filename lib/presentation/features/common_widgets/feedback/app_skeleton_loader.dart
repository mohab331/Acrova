import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:flutter/material.dart';

export 'skeleton_box.dart';

/// Shimmer skeleton loader wrapper.
///
/// Wraps any widget (usually grey placeholder containers) with an animated
/// shimmer using the luxuryProgressTrack / luxuryBackground gradient.
///
/// Usage:
/// ```dart
/// AppSkeletonLoader(
///   child: Column(
///     children: [
///       _SkeletonBox(width: double.infinity, height: 20),
///       SizedBox(height: 8),
///       _SkeletonBox(width: 120, height: 20),
///     ],
///   ),
/// )
/// ```
class AppSkeletonLoader extends StatefulWidget {
  const AppSkeletonLoader({required this.child, super.key});

  final Widget child;

  @override
  State<AppSkeletonLoader> createState() => _AppSkeletonLoaderState();
}

class _AppSkeletonLoaderState extends State<AppSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.shimmer,
    )..repeat();

    _shimmer = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Resources.colors.luxuryProgressTrack,
                Resources.colors.luxuryBackground,
                Resources.colors.luxuryProgressTrack,
              ],
              stops: [
                (_shimmer.value - 0.3).clamp(0.0, 1.0),
                _shimmer.value.clamp(0.0, 1.0),
                (_shimmer.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

