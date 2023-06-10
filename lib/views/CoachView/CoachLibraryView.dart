import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/VideoModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/VideosResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AddVideoWidget.dart';
import 'package:us_rowing/widgets/MediaWidget.dart';
import 'package:http/http.dart' as http;

class CoachLibraryView extends StatefulWidget {

  final String coachId;
  final String userId;

  CoachLibraryView({required this.coachId,required this.userId});

  @override
  _CoachLibraryViewState createState() => _CoachLibraryViewState();
}

class _CoachLibraryViewState extends State<CoachLibraryView> {

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
      backgroundColor: colorBackgroundLight,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            color: colorPrimary,
          ),
          child: Padding(
            padding: EdgeInsets.only( left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: colorWhite,
                    size: 18,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Media Library',
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  width: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: InkWell(
              child:  Container(
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
                            stat: '4',
                            type: typeCoach,
                            id: widget.coachId,
                            onAdd: onAdd,
                            isPdf: false,

                          ),
                          height: MediaQuery.of(context).size.height * 0.8,
                        ),
                      ],
                    ));
              },
            ),
          ),
          Expanded(
              child:
              isLoading?
              Center(child: CircularProgressIndicator(),):
              videos.length==0?
              Center(child: Text("No Videos",style: TextStyle(color: colorGrey),)):
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
                    VideoModel video=videos[index];
                    return MediaWidget(video: video,userId: widget.userId,show: false,onRefresh: onAdd,);
                  }),
          )
        ],
      ),
    );
  }

  getVideos() async {

    videos.clear();
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
