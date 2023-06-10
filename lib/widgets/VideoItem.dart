import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/VideoPalyerItems.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatelessWidget {

  final String videoUrl;

  VideoItem({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: VideoPlayerItems(
          videoPlayerController: VideoPlayerController.network(
            ApiClient.baseUrl+videoUrl,
          ),
          looping: false,
          autoplay: false,
        ),
      ),
    );
  }

}