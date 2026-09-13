import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:acrova/utils/helpers/app_viewer_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Reusable premium network image widget with responsive properties and shimmer placeholders.
///
/// Design system aligned:
/// - Shimmer placeholder using existing [AppSkeletonLoader]
/// - Premium error states using luxuryNavy/luxuryGold colors
/// - Custom cached network image
/// - Optional tap-to-view interaction routing to [ImageViewerPage]
class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.radius,
    this.openInViewerOnTap = false,
    this.viewerTitle,
    this.onTap,
    super.key,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double? radius;
  final bool openInViewerOnTap;
  final String? viewerTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final defaultRadius = radius ?? Resources.radius.$r8;

    final imageWidget = ClipRRect(
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
              colors: [Resources.colors.luxuryNavy, Resources.colors.luxuryInk],
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

    if (openInViewerOnTap || onTap != null) {
      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else if (openInViewerOnTap && imageUrl.trim().isNotEmpty) {
            AppViewerHelper.openImage(
              context,
              urlOrAsset: imageUrl,
              title: viewerTitle,
            );
          }
        },
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
