import 'package:flutter/material.dart';
import 'package:us_rowing/models/CoachModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/views/AthleteView/Coach/MyCoach/MyCoachFeed.dart';
import 'package:us_rowing/views/AthleteView/Coach/MyCoach/MyCoachVideos.dart';
import 'package:us_rowing/views/ChatScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'MyCoachInfo.dart';

class MyCoachDetails extends StatefulWidget {
  final String coachName;
  final String coachImage;
  final String coachId;
  final CoachModel coachModel;
  final String roomId;

  MyCoachDetails({this.coachName = '',this.coachImage='',required this.coachId,required this.coachModel,required this.roomId});

  @override
  _MyCoachDetailsState createState() => _MyCoachDetailsState();
}

class _MyCoachDetailsState extends State<MyCoachDetails> {

  late IO.Socket socket;
  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId=value.sId;
      });
      connectToSocket(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: mColorSwatch,
        primaryColor: colorPrimary,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,

        fontFamily: 'Circular',

      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              child: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                backgroundColor: colorPrimary,
                leading: Padding(
                  padding:  EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: colorWhite,
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(widget.coachName),
                ),
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/top-bar-feed-icon.png',
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/top-bar-library-icon.png',
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/top-bar-chat-icon.png',
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/top-bar-info-icon.png',
                        ),
                      ),
                    ),
                  ],
                  isScrollable: false,
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              MyCoachFeed(coachName: widget.coachName,coachImage: widget.coachImage,coachId: widget.coachId,),
              MyCoachVideos(coachId: widget.coachId,userId: userId,),
              ChatScreen(peerId: widget.coachId, peerAvatar: widget.coachImage, fromTeacher: false, currentUserId: userId, socket: socket, roomId: widget.roomId, share: false, workoutId: '', workoutName: '',workoutImage: '',),
              MyCoachInfo(coachModel: widget.coachModel,coachImage: widget.coachImage,),
            ],
          ),
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

    socket.connect();

    print(socket.connected);
  }
}
