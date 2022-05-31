import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../model/video.dart';

class VideoScreen extends StatefulWidget {
  final Video video;
  const VideoScreen({required this.video});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _ctrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: const BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        leadingWidth: 200.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'images/fo_logo.png',
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close)),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: YoutubePlayerIFrame(
          controller: _ctrl,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrl = YoutubePlayerController(
      initialVideoId: widget.video.id.toString(),
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,
      ),
    );

    _ctrl.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _ctrl.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }
}
