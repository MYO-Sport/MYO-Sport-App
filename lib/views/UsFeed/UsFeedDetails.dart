import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/USRoleResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Club/ClubView.dart';
import 'package:us_rowing/views/AthleteView/Saved/SavedView.dart';
import 'package:us_rowing/views/UsFeed/UsFeedEvent.dart';
import 'package:us_rowing/views/UsFeed/UsFeedInfo.dart';
import 'package:us_rowing/views/UsFeed/UsFeedVideos.dart';
import 'package:us_rowing/views/UsFeed/UsFeedView.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class UsFeedDetails extends StatefulWidget {
  final String clubName;
  final String clubImage;
  final String userId;

  UsFeedDetails(
      {this.clubName = '', this.clubImage = '', required this.userId});

  @override
  _UsFeedDetailsState createState() => _UsFeedDetailsState();
}

class _UsFeedDetailsState extends State<UsFeedDetails> {
  bool isLoading = true;
  bool isAdmin = false;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    // connectToSocket(widget.userId);
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
      length: 4,
      child: Scaffold(
        backgroundColor: colorBackgroundLight,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AppBar(
              backgroundColor: colorWhite,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        Text(
                          'MyoSport',
                          style: TextStyle(color: colorPrimary, fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: colorGrey,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClubView(allClubs: false,)));
                    },
                  ),
                  InkWell(
                      child: Image.asset(
                    imgSaved,
                    color: colorPrimary,
                    height: 12.8,
                    width: 10,
                  ),
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SavedView()));
                    },
                  )
                ],
              ),
              centerTitle: true,
              bottom: TabBar(
                unselectedLabelColor: colorGrey,
                labelColor: colorPrimary,
                unselectedLabelStyle: TextStyle(color: colorGrey,fontSize: 14),
                labelStyle: TextStyle(color: colorPrimary,fontSize: 14),
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
                  /*Tab(
                    icon: Container(
                      padding: EdgeInsets.all(10),
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
                      //   'assets/images/top-bar-info-icon.png',
                      //   height: 24,
                      //   width: 24,
                      // ),
                      text: 'Info',
                      iconMargin: EdgeInsets.only(bottom: 5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            UsFeedView(
              isAdmin: isAdmin,
            ),
            UsFeedVideos(
              isAdmin: isAdmin,
              userId: widget.userId,
            ),
            // UsChatScreen(currentUserId: widget.userId, socket: socket),
            UsFeedEvent(
              isAdmin: isAdmin,
            ),
            UsFeedInfo(),
          ],
        ),
      ),
    );
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

  getRoleInfo() async {
    print('userId: ' + widget.userId);
    String apiUrl = ApiClient.urlIsAdmin + widget.userId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      print('Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      USRoleResponse mResponse =
          USRoleResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isAdmin = mResponse.isAdmin;
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

}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
