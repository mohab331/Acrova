import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WalkthroughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;

  const WalkthroughVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  State<WalkthroughVideoPlayer> createState() => _WalkthroughVideoPlayerState();
}

class _WalkthroughVideoPlayerState extends State<WalkthroughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  String? _error;
  bool _showThumbnail = true;
  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _error = null;
      });

      final url = Uri.tryParse(widget.videoUrl);

      if (url == null) {
        throw Exception("Invalid video url");
      }

      _videoPlayerController = VideoPlayerController.networkUrl(url);

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        showOptions: false,
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
    } catch (e) {
      _error = e.toString();
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
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
            if (_chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized)
              Chewie(controller: _chewieController!),

            if (_showThumbnail)
              GestureDetector(
                onTap: () {
                  _chewieController?.play();
                  setState(() {
                    _showThumbnail = false;
                  });
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (widget.thumbnailUrl != null)
                      Image.network(widget.thumbnailUrl!, fit: BoxFit.cover)
                    else
                      Container(color: Resources.colors.luxurySurface),

                    Container(color: Colors.black12),

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

            if (_error != null)
              Container(
                color: Colors.black,
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
                        "Unable to load video",
                        style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
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
