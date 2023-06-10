import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:us_rowing/views/AthleteView/GroupChat/GroupChatScreen.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class GroupChatView extends StatelessWidget {
  final String groupName;
  final String groupId;
  final String currentUserId;
  final IO.Socket socket;
  final bool share;
  final String workoutId;
  final String workoutName;
  final String workoutImage;

  GroupChatView({
    required this.currentUserId,
    required this.socket,
    required this.groupName,
    required this.groupId,
    required this.share,
    required this.workoutId,
    required this.workoutName,
    required this.workoutImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
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
                    size: 18,
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
                  image: '',
                ),
                SizedBox(width: 10,),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groupName,
                        style: TextStyle(
                            color: colorWhite,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                      Text('group',style: TextStyle(color: colorWhite,fontSize: 10),),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: new GroupChatScreen(
        currentUserId: currentUserId,
        socket: socket,
        groupId: groupId, workoutId: workoutId,workoutName: workoutName,share: share,
        workoutImage: workoutImage,
      ),
    );
  }
}


