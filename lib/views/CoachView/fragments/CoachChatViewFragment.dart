import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/GroupModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GroupsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AllUserView.dart';
import 'package:us_rowing/views/AthleteView/GroupChat/CreateGroup.dart';
import 'package:us_rowing/views/AthleteView/GroupChat/GroupChatView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/EventInputField.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/network/response/RoomsResponse.dart';
import 'package:us_rowing/models/RoomModel.dart';
import 'package:us_rowing/views/ChatView.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/RoomWidget.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class CoachChatViewFragment extends StatefulWidget {
  final bool share;
  final String workoutId;
  final String workoutName;
  final String workoutImage;

  CoachChatViewFragment(
      {this.share = false,
      this.workoutId = '',
      this.workoutName = '',
      required this.workoutImage});

  @override
  _CoachChatViewFragmentState createState() => _CoachChatViewFragmentState();
}

class _CoachChatViewFragmentState extends State<CoachChatViewFragment> {
  late IO.Socket socket;
  bool isLoading = true;
  List<RoomModel> rooms = [];
  late String userId;
  late Dialog groupDialog;

  bool gettingGroup = true;
  List<GroupModel> groups = [];

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      connectToSocket(value.sId);
      getGroups();
    });

    groupDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Create Group',
                style: TextStyle(color: colorBlue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventInputField(
                controller: nameController,
                text: 'Enter Group Name',
                borderColor: colorBlack,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            PrimaryButton(
              text: 'Create',
              onPressed: () {
                if (nameController.text.isEmpty) {
                  showToast('Please enter the name of Group');
                } else {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => CreateGroup(
                                socket: socket,
                                userId: userId,
                                groupName: nameController.text,
                              )))
                      .then((value) {
                    if (value is bool && value) {
                      getGroups();
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AllUserView(
                    socket: socket,
                    userId: userId,
                    share: widget.share,
                    workoutName: widget.workoutName,
                    workoutId: widget.workoutId,
                    workoutImage: widget.workoutImage,
                  )));
        },
        child: const Icon(
          Icons.send,
          color: colorWhite,
        ),
        backgroundColor: Colors.blue,
      ),
      appBar: SimpleToolbar(title: 'Chat'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            /*InputFieldSuffix(
              text: 'Search here . . .',
              suffixImage: 'assets/images/filter-icon-for-bar.png',
              onChange: (text){

              },
            ),
            SizedBox(
              height: 20.0,
            ),*/
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Groups',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: Container(
                        height: 20,
                        width: 20,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: colorWhite,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => groupDialog);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            gettingGroup
                ? Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  )
                : groups.length == 0
                    ? Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No Joined Group Found.'),
                      )
                    : ListView.builder(
                        itemCount: groups.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          GroupModel group = groups[index];
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20.0),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: colorBackgroundLight,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    CachedImage(
                                      imageHeight: 30,
                                      imageWidth: 30,
                                      padding: 0,
                                      radius: 15,
                                      image: group.name,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        group.name,
                                        style: TextStyle(
                                            fontSize: 14.0, color: colorBlack),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GroupChatView(
                                    groupId: group.sId,
                                    groupName: group.name,
                                    currentUserId: userId,
                                    socket: socket,
                                    share: widget.share,
                                    workoutName: widget.workoutName,
                                    workoutId: widget.workoutId,
                                    workoutImage: widget.workoutImage,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Direct Messages',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: Container(
                        height: 20,
                        width: 20,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: colorWhite,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => AllUserView(
                                    socket: socket,
                                    userId: userId,
                                    share: widget.share,
                                    workoutName: widget.workoutName,
                                    workoutId: widget.workoutId,
                                    workoutImage: widget.workoutImage)))
                            .then((value) {
                          socket.emit('new-user', userId);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            isLoading
                ? Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )
                : rooms.length == 0
                    ? Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No Chat Found.'),
                      )
                    : ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          RoomModel room = rooms[index];
                          return InkWell(
                            child: RoomWidget( room: room),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatView(
                                      currentUserId: userId,
                                      peerId: room.userId,
                                      peerAvatar: room.userProfile,
                                      peerName: room.userName,
                                      peerType: room.userType,
                                      roomId: room.roomId,
                                      socket: socket,
                                      workoutId: widget.workoutId,
                                      workoutName: widget.workoutName,
                                      share: widget.share,
                                      workoutImage: widget.workoutImage),
                                ),
                              ).then((value){
                                socket.emit('new-user', userId);
                              });
                            },
                          );
                        }),
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
      print(data);
      RoomsResponse response = RoomsResponse.fromJson(data);
      print(response.toString());
      if (this.mounted) {
        setState(() {
          rooms = response.rooms;
          isLoading = false;
        });
      }
    });
    socket.connect();

    print(socket.connected);
  }

  getGroups() async {
    String apiUrl = ApiClient.urlGetGroups;
    print('Url: ' + apiUrl);
    print('user_id: ' + userId);

    final response = await http
        .post(Uri.parse(apiUrl), body: {'user_id': userId}).catchError((value) {
      setState(() {
        gettingGroup = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GroupsResponse mResponse =
          GroupsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          groups = mResponse.groups;
          gettingGroup = false;
        });
      } else {
        setState(() {
          gettingGroup = false;
        });
      }
    } else {
      setState(() {
        gettingGroup = false;
      });
    }
  }


}
