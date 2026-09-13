import 'dart:io';

import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

export 'package:acrova/presentation/app/navigation/args/navigation_args.dart'
    show ImageViewerArgs;

class ImageViewerPage extends StatefulWidget {
  const ImageViewerPage({this.args, super.key});

  final ImageViewerArgs? args;

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  int _retryKey = 0;

  void _retry() {
    setState(() {
      _retryKey++;
    });
  }

  ImageProvider _resolveImageProvider(String urlOrAsset) {
    if (urlOrAsset.startsWith('assets/')) {
      return AssetImage(urlOrAsset);
    }
    if (urlOrAsset.startsWith('http://') || urlOrAsset.startsWith('https://')) {
      return CachedNetworkImageProvider(urlOrAsset);
    }
    return FileImage(File(urlOrAsset));
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.args?.title ?? '';
    final urlOrAsset = widget.args?.urlOrAsset.trim() ?? '';
    final loc = context.localization;

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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (urlOrAsset.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.download_rounded, color: Colors.white),
              onPressed: () {
                DownloadHelper.downloadAndShare(context, urlOrAsset, title);
              },
            ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: urlOrAsset.isEmpty
          ? CommonErrorWidget(
              title: loc.errorGenericTitle,
              message: loc.error_message_unknown,
              retryLabel: loc.errorRetryLabel,
              onRetry: _retry,
            )
          : PhotoView(
              key: ValueKey('image_viewer_${urlOrAsset}_$_retryKey'),
              imageProvider: _resolveImageProvider(urlOrAsset),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              loadingBuilder: (context, event) {
                final total = event?.expectedTotalBytes;
                final loaded = event?.cumulativeBytesLoaded;
                final progress = total != null && total > 0 && loaded != null
                    ? loaded / total
                    : null;
                return Center(
                  child: CircularProgressIndicator(
                    value: progress,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Resources.colors.luxuryGoldLight,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Center(
                child: CommonErrorWidget(
                  title: loc.errorGenericTitle,
                  message: loc.error_message_unknown,
                  retryLabel: loc.errorRetryLabel,
                  onRetry: _retry,
                ),
              ),
            ),
    );
  }
}
