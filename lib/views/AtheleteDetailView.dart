
import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/pages/AthleteInfoPage.dart';
import 'package:us_rowing/views/pages/WorkoutInfoPage.dart';
import 'ChatScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AthleteDetailView extends StatefulWidget {
  final String athleteId;
  final String athleteName;
  final String email;
  final String img;
  final int index;
  final String userId;

  AthleteDetailView({this.athleteName='',required this.email,required this.img,required this.athleteId,this.index=2,required this.userId});



  @override
  _AthleteDetailViewState createState() => _AthleteDetailViewState();
}

class _AthleteDetailViewState extends State<AthleteDetailView> {

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToSocket('','');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.index,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: colorWhite,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: colorPrimary,
                size: 18,
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            title: Text(widget.athleteName,style: TextStyle(color: colorBlack),),
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
                Tab(
                  // icon: Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Image.asset(
                  //     'assets/images/top-bar-chat-icon.png',
                  //     color: colorGrey,
                  //   ),
                  // ),
                  text: 'Chat'
                ),
                Tab(
                  // icon: Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Image.asset(
                  //     IMG_WORKoUTiCON,
                  //   ),
                  // ),
                  text: 'Workouts',
                ),
                Tab(
                  // icon: Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Image.asset(
                  //     'assets/images/top-bar-info-icon.png',
                  //   ),
                  // ),
                  text: 'Info',
                ),
              ],
              isScrollable: false,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ChatScreen(peerAvatar: '', peerId: widget.athleteId, fromTeacher: false, currentUserId: widget.userId,socket: socket,roomId: '', workoutId: '', share: false, workoutName: '',workoutImage: '',),
            WorkoutInfoPage(athleteId: widget.athleteId,),
            AthleteInfoPage(name: widget.athleteName,email: widget.email, image: widget.img,userId: widget.athleteId,),
          ],
        ),
      ),
    );
  }

  connectToSocket(String url,String userId) {
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
