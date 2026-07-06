import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReproductorScreen extends StatefulWidget {
  final String url_video;
  const ReproductorScreen({super.key, required this.url_video});

  @override
  State<ReproductorScreen> createState() => _ReproductorScreenState();
}

class _ReproductorScreenState extends State<ReproductorScreen> {
  late YoutubePlayerController _youtubePlayerController;
  bool _hasv = false;

  @override
  void initState() {
    super.initState();
    if (widget.url_video.isNotEmpty) {
      setState(() {
        _hasv = true;
      });
    }

    if (_hasv) {
      print("Hay video: ${widget.url_video}");
      final String videoId =
          YoutubePlayerController.convertUrlToId(widget.url_video) ?? "";
      print("id del videio: ${videoId}");
      _youtubePlayerController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          mute: false, // Aquí se configuran los parámetros ahora
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Reproductor de películas'),
          YoutubePlayer(controller: _youtubePlayerController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.close();
    super.dispose();
  }
}
