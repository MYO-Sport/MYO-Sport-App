import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/VideoModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/VideosResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/VideoItem.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/ZoomImage.dart';

import '../../../../widgets/CachedImage.dart';

class MyCoachVideos extends StatefulWidget {

  final String coachId;
  final String userId;

  MyCoachVideos({required this.coachId,required this.userId});

  @override
  _MyCoachVideosState createState() => _MyCoachVideosState();
}

class _MyCoachVideosState extends State<MyCoachVideos> {

  bool isLoading=true;
  List<VideoModel> videos=[];

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0,),

          Expanded(
              child:
              isLoading?
              Center(child: CircularProgressIndicator(),):
              videos.length==0?
              Center(child: Text("No Videos",style: TextStyle(color: colorGrey),)):
              GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                  ),
                  itemCount: videos.length,
                  itemBuilder: (context,index){
                    VideoModel video=videos[index];
                    if(video.mediaType==postVideo){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VideoItem(videoUrl: video.media),
                      );
                    }else{
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(child: CachedImage(image: ApiClient.baseUrl+video.media,
                        ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ZoomImage(url: ApiClient.baseUrl+video.media)));
                          },
                        ),
                      );
                    }
                  })
          )
        ],
      ),
    );
  }

  getVideos() async {
    setState(() {
      isLoading = true;
    });

    print('coachId: ' + widget.coachId);
    print('userId: ' + widget.userId);

    String apiUrl = ApiClient.urlGetCoachVideos ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'coach_id' : widget.coachId
        }
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      VideosResponse mResponse =
      VideosResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          videos = mResponse.videos;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: Something Went Wrong');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  onAdd() {
    print('On Add is called in my club feed');
    setState(() {
      isLoading = true;
    });
    getVideos();
  }

}
