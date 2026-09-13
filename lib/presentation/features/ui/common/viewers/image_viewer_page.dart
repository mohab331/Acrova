import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

export 'package:acrova/presentation/app/navigation/args/navigation_args.dart'
    show ImageViewerArgs;

class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({this.args, super.key});

  final ImageViewerArgs? args;

  @override
  Widget build(BuildContext context) {
    final title = args?.title ?? '';
    final urlOrAsset = args?.urlOrAsset ?? '';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Colors.white),
            onPressed: () {
              if (urlOrAsset.isNotEmpty) {
                DownloadHelper.downloadAndShare(
                  urlOrAsset,
                  '$title.jpg',
                );
              }
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: urlOrAsset.isEmpty
          ? const SizedBox.shrink()
          : PhotoView(
              imageProvider: urlOrAsset.startsWith('assets/')
                  ? AssetImage(urlOrAsset) as ImageProvider
                  : CachedNetworkImageProvider(urlOrAsset),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
            ),
    );
  }
}
