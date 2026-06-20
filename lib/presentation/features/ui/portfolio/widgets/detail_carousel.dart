import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailCarousel extends StatelessWidget {
  const DetailCarousel({
    required this.imageUrls,
    required this.controller,
    required this.onPageChanged,
    super.key,
  });

  final List<String> imageUrls;
  final PageController controller;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: imageUrls.length,
      itemBuilder: (_, index) => AppCachedNetworkImage(
        imageUrl: imageUrls[index],
        fit: BoxFit.cover,
        radius: 0,
      ),
    );
  }
}
