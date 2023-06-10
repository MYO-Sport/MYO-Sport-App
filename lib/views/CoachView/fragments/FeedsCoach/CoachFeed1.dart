import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoachFeed1 extends StatefulWidget {

  @override
  _CoachFeed1State createState() => _CoachFeed1State();
}

class _CoachFeed1State extends State<CoachFeed1> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: liveUrls[0],
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
