import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItems extends StatefulWidget {

  late final VideoPlayerController videoPlayerController;
  late final bool looping;
  late final bool autoplay;

  VideoPlayerItems({required this.autoplay,required this.looping,required this.videoPlayerController});

  @override
  _VideoPlayerItemsState createState() => _VideoPlayerItemsState();
}

class _VideoPlayerItemsState extends State<VideoPlayerItems> with WidgetsBindingObserver {

  late ChewieController _chewieController;
  bool loaded=false;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    if( _chewieController.isPlaying){
      _chewieController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBlack,
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
      child:
          loaded?
      Chewie(
        controller: _chewieController,
      ):
          Center(child: CircularProgressIndicator(),),
    );
  }

  initializeController() async{
    await widget.videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'Something Went Wrong',
            style: TextStyle(color: Colors.white,),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
    setState(() {
      loaded=true;
    });
  }
}
