import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReproductorScreen extends StatefulWidget {
  final String url_video;
  const ReproductorScreen({super.key, required this.url_video});

  @override
  State<ReproductorScreen> createState() => _ReproductorScreenState();
}

class _ReproductorScreenState extends State<ReproductorScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    print('URL Video: ${widget.url_video}');
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url_video))
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
          fullScreenByDefault: true,
          aspectRatio: _controller.value.aspectRatio,
          errorBuilder: (context, errorMessage) => Text(errorMessage),
        );
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            _controller.value.isInitialized &&
                _chewieController.videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Chewie(controller: _chewieController),
              )
            : Container(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
