import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoachFeed3 extends StatefulWidget {

  @override
  _CoachFeed3State createState() => _CoachFeed3State();
}

class _CoachFeed3State extends State<CoachFeed3> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: liveUrls[2],
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: colorBlack,
        body: SafeArea(
          child: Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: colorPrimary,
              progressColors: ProgressBarColors(
                playedColor: colorPrimary,
                handleColor: colorPrimary,
              ),
              onReady:() {
                _controller.play();
              },
            ),
          ),
        )
    );
  }
}
