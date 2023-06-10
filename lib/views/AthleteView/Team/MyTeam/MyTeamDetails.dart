import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/TeamRoleResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Team/MyTeam/MyTeamEvent.dart';
import 'package:us_rowing/views/AthleteView/Team/MyTeam/MyTeamMembers.dart';
import 'package:us_rowing/views/AthleteView/Team/MyTeam/TeamChatScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import 'MyTeamFeed.dart';
import 'MyTeamInfo.dart';
import 'MyTeamVideos.dart';

class MyTeamDetails extends StatefulWidget {
  final String teamName;
  final String teamImage;
  final String teamId;
  final TeamModel teamModel;
  final String userId;

  MyTeamDetails({this.teamName = '', this.teamImage = '',required this.teamId,required this.teamModel, required this.userId});

  @override
  _MyTeamDetailsState createState() => _MyTeamDetailsState();
}

class _MyTeamDetailsState extends State<MyTeamDetails> {

  late IO.Socket socket;
  bool isAdmin=false;
  bool isModerator=false;
  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    connectToSocket(widget.userId);
    getRoleInfo();
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return Container(
          color: colorBackgroundLight,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(child: CircularProgressIndicator()));
    }
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: colorBackgroundLight,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AppBar(

              leading: SizedBox(),
              leadingWidth: 0,
              backgroundColor: colorWhite,
              title: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorPrimary,
                        size: 18,
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Image.asset(IMG_TEAMS,height: 18,width: 18,color: colorBlack,),
                        SizedBox(width: 10,),
                        Flexible(child: FittedBox(fit:BoxFit.fitWidth,child: Text(widget.teamName,style: TextStyle(color: colorBlack,fontSize: 18),maxLines: 1))),
                      ], ),
                    ),
                    SizedBox(height: 18,width: 18,)
                  ],
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                unselectedLabelColor: colorGrey,
                labelColor: colorPrimary,
                unselectedLabelStyle: TextStyle(color: colorGrey,fontSize: 12),
                labelStyle: TextStyle(color: colorPrimary,fontSize: 12),
                indicatorColor: colorPrimary,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/tab_background.png'),fit: BoxFit.fill),
                ),
                tabs: [
                  SizedBox(
                    height: 50,
                    child: Tab(
                      // icon: Image.asset(
                      //   'assets/images/top-bar-feed-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Feeds',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Tab(
                      // icon: Image.asset(
                      //   'assets/images/top-bar-library-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Media',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Tab(
                      // icon: Image.asset(
                      //   'assets/images/top-bar-chat-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Chat',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Tab(
                      // icon: Image.asset(
                      //   'assets/images/top-bar-event-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Events',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Tab(
                      // icon: Image.asset(
                      //   IMG_ATHLETES,
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Athletes',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Tab(
                      // icon: Image.asset(
                      //   'assets/images/top-bar-info-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Info',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                ],
                isScrollable: false,
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MyTeamFeed(
              teamImage: widget.teamImage,
              teamName: widget.teamName,
              teamId: widget.teamId, isModerator: isModerator, isAdmin: isAdmin,
            ),
            MyTeamVideos(userId: widget.userId,teamId: widget.teamId, isAdmin: isAdmin, isModerator: isModerator,),
            TeamChatScreen(teamId: widget.teamId, currentUserId: widget.userId, socket: socket),
            MyTeamEvent(teamId: widget.teamId, isAdmin: isAdmin, isModerator: isModerator,),
            MyTeamMembers(
              teamId: widget.teamId,
            ),
            MyTeamInfo(teamImage: widget.teamImage,teamModel: widget.teamModel,),
          ],
        ),
      ),
    );
  }

  getRoleInfo() async {
    print('userId: ' + widget.userId);
    print('team_id: ' + widget.teamId);
    String apiUrl = ApiClient.urlVerifyTeam ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'user_id':widget.userId,
          'team_id' :widget.teamId
        }
    )
        .catchError((value) {
      print('Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      TeamRoleResponse mResponse =
      TeamRoleResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isAdmin=mResponse.isTeamAdmin;
          isModerator=mResponse.isTeamMod;
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading=false;
        });
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

  connectToSocket(String userId) {
    socket = IO.io(ApiClient.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.onConnect((data) {
      print('Connected to socket');
      socket.emit('new-user', userId);
    });
    socket.on('new-user', (data) {
      print('value is taken');
      /*RoomsResponse response = RoomsResponse.fromJson(data);
      print(response.toString());
      if(this.mounted){
        setState(() {
          rooms = response.rooms;
          isLoading = false;
        });
      }*/
    });
    socket.connect();

    print(socket.connected);
  }
}
