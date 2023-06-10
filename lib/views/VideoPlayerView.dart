import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/VideoPalyerItems.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: colorPrimary,
        automaticallyImplyLeading: false,
        title: Text('Video Feed'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          VideoPlayerItems(
            videoPlayerController: VideoPlayerController.network(
                'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
            ),
            looping: false,
            autoplay: false,
          ),
          VideoPlayerItems(
            videoPlayerController: VideoPlayerController.network(
                'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
            ),
            looping: false,
            autoplay: false,
          ),
          VideoPlayerItems(
            videoPlayerController: VideoPlayerController.network(
                'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
            ),
            looping: false,
            autoplay: false,
          ),
          VideoPlayerItems(
            videoPlayerController: VideoPlayerController.network(
                'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
            ),
            looping: false,
            autoplay: false,
          ),
        ],
      ),
    );
  }
}