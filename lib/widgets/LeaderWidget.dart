import 'package:flutter/material.dart';
import 'package:us_rowing/models/EventAttendantModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class LeaderWidget extends StatelessWidget {

  final EventAttendantModel athlete;
  final int index;
  final bool last;
  LeaderWidget({required this.athlete,required this.index,required this.last});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: last?null:Border(bottom: BorderSide(color: colorGrey,width: last?0:0.5)),
      ),
      child: Row(
        children: [
          CachedImage(
            image:
            ApiClient.baseUrl+athlete.userProfileImage,
            imageHeight: 47.0,
            radius: 6,
            imageWidth: 47,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  athlete.userName,
                  style:
                  TextStyle(color: colorBlack, fontSize: 14),
                ),
                Text(
                  '0 Points',
                  style:
                  TextStyle(color: colorTextSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Text('#$index',style: TextStyle(color: colorTextSecondary,fontSize: 18),),
          Icon(Icons.arrow_drop_up,color: colorGreen,)

        ],
      ),
    );
  }
}
