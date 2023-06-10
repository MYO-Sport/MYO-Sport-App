import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class WorkoutInfoWidget extends StatelessWidget {
  final String date;
  final String time;
  final String steps;
  final String calories;
  final String heartRate;

  WorkoutInfoWidget(
      {required this.date, required this.time, required this.steps, required this.calories, required this.heartRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: colorBlue, width: 0.5))),
      child: Row(
        children: <Widget>[
          Expanded(flex: 1,child: Text(date, style: TextStyle(fontSize: 14,color: colorGrey),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),),
          Expanded(flex: 1,child: Text(time, style: TextStyle(fontSize: 14,color: colorGrey,),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),),
          Expanded(flex: 1,child: Text(steps, style: TextStyle(fontSize: 14,color: colorGrey,),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),),
          Expanded(flex: 1,child: Text(calories, style: TextStyle(fontSize: 14,color: colorGrey,),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),),
          Expanded(flex: 1,child: Text(heartRate, style: TextStyle(fontSize: 14,color: colorGrey,),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),),
        ],
      ),
    );
  }
}