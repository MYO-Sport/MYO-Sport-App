import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:us_rowing/widgets/CachedImage.dart';

import 'ChatScreen.dart';

class ChatView extends StatelessWidget {
  final String peerId;
  final String peerAvatar;
  final String peerName;
  final String currentUserId;
  final String roomId;
  final IO.Socket socket;
  final bool share;
  final String workoutId;
  final String workoutName;
  final String workoutImage;
  final String peerType;

  ChatView({
    required this.currentUserId,
    required this.peerId,
    required this.peerAvatar,
    required this.peerName,
    required this.roomId,
    required this.socket,
    required this.share,
    required this.workoutId,
    required this.workoutName,
    required this.workoutImage,
    required this.peerType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
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
            padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorWhite,
                    size: 18
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10,),
                CachedImage(
                  imageHeight: 40,
                  imageWidth: 40,
                  padding: 0,
                  radius: 20,
                  image: ApiClient.baseUrl+peerAvatar,
                ),
                SizedBox(width: 10,),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        peerName,
                        style: TextStyle(
                            color: colorWhite,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                      Text(peerType,style: TextStyle(color: colorWhite,fontSize: 10),),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: new ChatScreen(
          currentUserId: currentUserId,
          peerId: peerId,
          peerAvatar: peerAvatar,
          fromTeacher: false,
        socket: socket,
        roomId: roomId, workoutName: workoutName, workoutId: workoutId, share: share,
        workoutImage: workoutImage,
      ),
    );
  }


}


