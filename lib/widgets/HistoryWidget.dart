import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/WorkoutDetail.dart';

class HistoryWidget extends StatelessWidget {
  final String workoutId;
  final String workOut;
  final String days;
  final DateTime now;
  final String imgUrl;
  HistoryWidget({this.days='',this.workOut='',required this.now,required this.workoutId,required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(left: 15.0,right: 30.0,top: 14.0,bottom: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(workOut),
            Text(getTime(),style: TextStyle(color: colorGrey),)
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkoutDetail(workoutId: workoutId,workoutName: workOut,share: true,imgUrl: imgUrl,)));
      },


    );
  }

  String getTime(){
    DateTime time=DateTime.parse(days);
    int i=now.difference(time).inDays;
    if(i==0){
      return 'today';
    }
    if(i==1){
      return '1 day ago';
    }
    if(i>1){
      return '$i days ago';
    }

    return '';
  }
}