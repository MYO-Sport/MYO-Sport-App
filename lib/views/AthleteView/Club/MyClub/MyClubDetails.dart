import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ClubRoleResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Club/MyClub/MyClubEvent.dart';
import 'package:us_rowing/views/AthleteView/Club/MyClub/MyClubTeam.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import 'MyClubFeed.dart';
import 'MyClubInfo.dart';
import 'MyClubVideos.dart';

class MyClubDetails extends StatefulWidget {
  final String clubName;
  final String clubImage;
  final String clubId;
  final ClubModel clubModel;
  final String userId;

  MyClubDetails(
      {this.clubName = '',
      this.clubImage = '',
      required this.clubId,
      required this.clubModel,
      required this.userId});

  @override
  _MyClubDetailsState createState() => _MyClubDetailsState();
}

class _MyClubDetailsState extends State<MyClubDetails> {
  bool isLoading = true;
  bool isAdmin = false;
  bool isModerator = false;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    getRoleInfo();
    // connectToSocket('', widget.userId);
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
      length: 5,
      child: Scaffold(
        backgroundColor: colorBackgroundLight,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AppBar(
              backgroundColor: colorWhite,
              leading: SizedBox(),
              leadingWidth: 0,
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IMG_CLUB,
                            height: 18,
                            width: 18,
                            color: colorBlack,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                              child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(widget.clubName,
                                      style: TextStyle(
                                          color: colorBlack, fontSize: 18),
                                      maxLines: 1))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 24,
                    )
                  ],
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                unselectedLabelColor: colorGrey,
                labelColor: colorPrimary,
                unselectedLabelStyle: TextStyle(color: colorGrey, fontSize: 14),
                labelStyle: TextStyle(color: colorPrimary, fontSize: 14),
                indicatorColor: colorPrimary,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/tab_background.png'),
                      fit: BoxFit.fill),
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
                  /*Tab(
                      icon: Container(
                        padding: EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/images/top-bar-chat-icon.png',
                        ),
                      ),
                    ),*/
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
                      //   'assets/images/top-bar-team-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Teams',
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
            MyClubFeed(
              clubImage: widget.clubImage,
              clubName: widget.clubName,
              clubId: widget.clubId,
              isAdmin: isAdmin,
              isModerator: isModerator,
            ),
            MyClubVideos(
              clubId: widget.clubId,
              userId: widget.userId,
              isModerator: isModerator,
              isAdmin: isAdmin,
            ),
            // ClubChatScreen(clubId: widget.clubId, currentUserId: widget.userId, socket: socket),
            MyClubEvent(
              clubId: widget.clubId,
              isAdmin: isAdmin,
              isModerator: isModerator,
            ),
            MyClubTeam(
              userId: widget.userId,
              clubImage: widget.clubImage,
              clubName: widget.clubName,
              clubId: widget.clubId,
            ),
            MyClubInfo(
              clubModel: widget.clubModel,
              clubImage: widget.clubImage,
              userId: widget.userId,
            ),
          ],
        ),
      ),
    );
  }

  getRoleInfo() async {
    print('userId: ' + widget.userId);
    print('clubId: ' + widget.clubId);
    String apiUrl = ApiClient.urlVerifyClub;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'club_id': widget.clubId
    }).catchError((value) {
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      ClubRoleResponse mResponse =
          ClubRoleResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isAdmin = mResponse.isClubAdmin;
          isModerator = mResponse.isClubMod;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

  connectToSocket(String url, String userId) {
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
