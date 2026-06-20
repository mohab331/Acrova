import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/project_image_placeholder.dart';
import 'package:flutter/material.dart';

class ProjectImage extends StatelessWidget {
  const ProjectImage({
    this.thumbnailUrl,
    required this.height,
    super.key,
  });

  final String? thumbnailUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
      return AppCachedNetworkImage(
        imageUrl: thumbnailUrl!,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        radius: Resources.radius.$r0,
      );
    }
    return ProjectImagePlaceholder(height: height);
  }
}
