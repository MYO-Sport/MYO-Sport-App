import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/SavedVideoModel.dart';
import 'package:us_rowing/models/VideoModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/SavedVideoResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AddVideoWidget.dart';
import 'package:us_rowing/widgets/MediaWidget.dart';
import 'package:http/http.dart' as http;

class SavedMediaView extends StatefulWidget {

  final bool isAdmin;
  final String userId;

  SavedMediaView({required this.isAdmin,required this.userId});

  @override
  _SavedMediaViewState createState() => _SavedMediaViewState();
}

class _SavedMediaViewState extends State<SavedMediaView> {


  bool isLoading=true;
  List<SavedVideoModel> videos=[];

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.isAdmin?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: InkWell(
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: colorWhite
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Post in media library',
                      style: TextStyle(color: colorGrey),
                    ),
                    Container(
                        width: 30.0,
                        height: 30.0,
                        child: Icon(
                          Icons.camera_alt,
                          color: colorGrey,
                        )),
                  ],
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Wrap(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              bottom:
                              MediaQuery.of(context).viewInsets.bottom),
                          child: AddVideoWidget(
                            type: typeUsFeed,
                            id: '',
                            onAdd: onAdd, stat: '3',
                          ),
                          height: MediaQuery.of(context).size.height * 0.8,
                        ),
                      ],
                    ));
              },
            ),
          ):SizedBox(),
          Expanded(
            child:
            isLoading?
            Center(child: CircularProgressIndicator(),):
            videos.length==0?
            Center(child: Text('No Media Found.',style: TextStyle(color: colorGrey),),):
            GridView.builder(
                itemCount: videos.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context,index){
                  VideoModel video=videos[index].video;
                  return MediaWidget(video: video,userId: widget.userId,options: false,onRefresh: (){

                  },);
                }),
          )
        ],
      ),
    );
  }

  getVideos() async {

    setState(() {
      isLoading = true;
    });


    String apiUrl = ApiClient.urlGetSavedMedia ;

    
    final response = await http
        .post(
      Uri.parse(apiUrl), body: {
    'user_id': widget.userId,
    'skip': '0',
    'limit': '5'
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
      SavedVideoResponse mResponse =
      SavedVideoResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          videos = mResponse.savedVideos;
          /*for(VideoModel video in videos){
            print('Video Type: '+video.videoType);
            if(video.videoType==typeCoach){
              coachVideos.add(video);
            }else{
              athleteVideos.add(video);
            }
          }*/
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
