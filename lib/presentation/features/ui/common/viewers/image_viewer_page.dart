import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerArgs {
  final String title;
  final String urlOrAsset;

  const ImageViewerArgs({
    required this.title,
    required this.urlOrAsset,
  });
}

class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({
    required this.args,
    super.key,
  });

  final ImageViewerArgs args;

  @override
  Widget build(BuildContext context) {
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
          args.title,
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Colors.white),
            onPressed: () {
              DownloadHelper.downloadAndShare(args.urlOrAsset, '${args.title}.jpg');
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: PhotoView(
        imageProvider: args.urlOrAsset.startsWith('assets/')
            ? AssetImage(args.urlOrAsset) as ImageProvider
            : CachedNetworkImageProvider(args.urlOrAsset),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
