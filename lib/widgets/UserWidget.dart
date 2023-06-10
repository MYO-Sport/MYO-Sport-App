import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/ChatView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class UserWidget extends StatelessWidget {
  final String name;
  final String image;
  final String id;
  final String currentId;
  final IO.Socket socket;
  final bool share;
  final String workoutId;
  final String workoutName;
  final String workoutImage;
  final String userType;

  UserWidget({this.image='',this.name='',required this.id, required this.currentId,required this.socket,required this.share,required this.workoutId,required this.workoutName,required this.workoutImage,required this.userType});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 80.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    CachedImage(image: image,radius: 100,),
                    SizedBox(width: 10,),
                    Text(name),
                  ],
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.chat,color: colorBlue,),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView(currentUserId: currentId, peerId: id, peerAvatar: image, peerName: name, roomId: '', socket: socket, share: share, workoutName: workoutName, workoutId: workoutId,workoutImage: workoutImage,peerType: userType,)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

