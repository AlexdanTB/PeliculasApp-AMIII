import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReproductorYt extends StatefulWidget {
  final String url_video;
  const ReproductorYt(this.url_video, {super.key});

  @override
  State<ReproductorYt> createState() => _ReproductorYtState();
}

class _ReproductorYtState extends State<ReproductorYt> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final String videoId =
        YoutubePlayerController.convertUrlToId(widget.url_video) ?? "";
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
