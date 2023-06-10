import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/VideoModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/VideosResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/pages/DocumentPage.dart';
import 'package:us_rowing/widgets/AddVideoWidget.dart';
import 'package:us_rowing/widgets/MediaWidget.dart';
import 'package:http/http.dart' as http;

class MyTeamVideos extends StatefulWidget {

  final String teamId;
  final String userId;
  final bool isAdmin;
  final bool isModerator;

  MyTeamVideos({required this.teamId,required this.userId,required this.isAdmin,required this.isModerator});

  @override
  _MyTeamVideosState createState() => _MyTeamVideosState();
}

class _MyTeamVideosState extends State<MyTeamVideos> {

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.isAdmin || widget.isModerator?
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
                                type: typeTeam,
                                id: widget.teamId,
                                onAdd: onAdd, stat: '2',
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
              DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: colorBackgroundLight,
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    leadingWidth: 0,
                    leading: SizedBox(),
                    elevation: 0,
                    backgroundColor: colorWhite,
                    title:TabBar(
                      tabs: [
                        Tab(
                          icon: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('Media',style: TextStyle(color: colorPrimary),),
                          ),
                        ),
                        Tab(
                          icon: Container(
                              padding: EdgeInsets.all(10),
                              child: Text('Docs',style: TextStyle(color: colorPrimary),)
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
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
                            VideoModel video=videos[index];
                            return MediaWidget(video: video,userId: widget.userId,onRefresh: onAdd,);
                          }),
                      DocumentPage(id: widget.teamId, stat: '2',userId: widget.userId,),
                    ],
                  ),
                ),
              ),
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

    print('teamId: ' + widget.teamId);

    String apiUrl = ApiClient.urlGetTeamVideos ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'team_id' : widget.teamId
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
