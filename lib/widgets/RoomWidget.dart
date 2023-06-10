
import 'package:flutter/cupertino.dart';
import 'package:us_rowing/models/RoomModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'CachedImage.dart';

class RoomWidget extends StatelessWidget{

  final RoomModel room;

  RoomWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 20.0),
      child: Container(
        height: 50,
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: colorBackgroundLight,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: <Widget>[
            CachedImage(
              imageHeight: 40,
              imageWidth: 40,
              padding: 0,
              radius: 6,
              image:
              ApiClient.baseUrl + room.userProfile,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    room.userName,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: colorBlack),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    room.lastMessage.body,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 10.0,
                        color: colorTextSecondary),
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(getTime(room.lastMessage.createdAt),style: TextStyle(color: colorGrey,fontSize: 9),),
                Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTime(String string){
    if(string.isEmpty){
      return '';
    }

    DateTime createTime=DateTime.parse(string);
    return timeago.format(createTime,locale: 'en_short');
  }

}