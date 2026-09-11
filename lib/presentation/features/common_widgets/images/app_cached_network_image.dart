import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Reusable premium network image widget with responsive properties and shimmer placeholders.
///
/// Design system aligned:
/// - Shimmer placeholder using existing [AppSkeletonLoader]
/// - Premium error states using luxuryNavy/luxuryGold colors
/// - Custom cached network image
class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.radius,
    super.key,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final defaultRadius = radius ?? Resources.radius.$r8;

    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => AppSkeletonLoader(
          child: Container(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            color: Resources.colors.luxuryProgressTrack,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Resources.colors.luxuryNavy,
                Resources.colors.luxuryInk,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.apartment_outlined,
              size: Resources.iconSizes.$32,
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
