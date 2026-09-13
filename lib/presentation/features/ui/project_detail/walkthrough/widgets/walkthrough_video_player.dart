import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WalkthroughVideoPlayer extends StatefulWidget {
  const WalkthroughVideoPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
  });

  final String videoUrl;
  final String? thumbnailUrl;

  @override
  State<WalkthroughVideoPlayer> createState() => _WalkthroughVideoPlayerState();
}

class _WalkthroughVideoPlayerState extends State<WalkthroughVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  String? _error;
  bool _isLoading = true;
  bool _showThumbnail = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (widget.videoUrl.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Video URL is empty';
        });
      }
      return;
    }

    try {
      final uri = Uri.tryParse(widget.videoUrl);

      if (uri == null ||
          !uri.hasScheme ||
          (uri.scheme != 'http' && uri.scheme != 'https')) {
        throw Exception('Invalid video URL');
      }

      final controller = VideoPlayerController.networkUrl(uri);

      _videoPlayerController = controller;

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      _chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: controller.value.aspectRatio > 0
            ? controller.value.aspectRatio
            : 16 / 9,
        autoPlay: false,
        looping: false,
        showOptions: false,
        allowFullScreen: true,
        allowMuting: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Resources.colors.luxuryGoldLight,
          handleColor: Resources.colors.luxuryGoldLight,
          bufferedColor: Colors.white54,
          backgroundColor: Colors.white24,
        ),
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: Resources.colors.luxuryGoldLight,
          handleColor: Resources.colors.luxuryGoldLight,
          bufferedColor: Colors.white54,
          backgroundColor: Colors.white24,
        ),
      );

      setState(() {
        _isLoading = false;
        _error = null;
      });
    } catch (e, stackTrace) {
      AppLogger.instance.logError(
        'WalkthroughVideoPlayer',
        error: e,
        stackTrace: stackTrace,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _playVideo() {
    final controller = _videoPlayerController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    setState(() {
      _showThumbnail = false;
    });

    controller.play();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video
            if (_chewieController != null)
              Chewie(controller: _chewieController!)
            else
              Container(color: Resources.colors.luxurySurface),

            // Loading
            if (_isLoading) const Center(child: CircularProgressIndicator()),

            // Thumbnail / play button
            if (!_isLoading && _error == null && _showThumbnail)
              GestureDetector(
                onTap: _playVideo,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (widget.thumbnailUrl != null)
                      Image.network(
                        widget.thumbnailUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: Resources.colors.luxurySurface,
                          );
                        },
                      )
                    else
                      Container(color: Resources.colors.luxurySurface),

                    Container(color: Colors.black26),

                    const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ],
                ),
              ),

            // Error
            if (!_isLoading && _error != null)
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: Resources.iconSizes.$32,
                      ),
                      SizedBox(height: Resources.verticalDims.$16),
                      Text(
                        context.localization.walkthroughUnableToLoadVideo,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
