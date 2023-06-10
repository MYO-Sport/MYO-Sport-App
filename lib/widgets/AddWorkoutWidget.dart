
import 'package:flutter/material.dart';
import 'package:us_rowing/models/WorkOutActivitiesModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/WorkoutInformation.dart';

import 'CachedImage.dart';

class AddWorkoutWidget extends StatefulWidget {
  final String image;
  final String workoutId;
  final String workoutName;
  final String type;
  final List<WorkOutActivities> activities;

  AddWorkoutWidget({this.image='',this.workoutName='',this.type='',required this.activities, required this.workoutId});

  @override
  _AddWorkoutWidgetState createState() => _AddWorkoutWidgetState();
}

class _AddWorkoutWidgetState extends State<AddWorkoutWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  ),
              child: CachedImage(image: ApiClient.baseUrl+widget.image,imageWidth: MediaQuery.of(context).size.width,radius: 8,),
            ),
          ),
          Positioned(
            top: 15.0,
            left: 28.0,
            child: Text(widget.workoutName,style: TextStyle(fontSize: 18.0,color: colorWhite,fontWeight: FontWeight.w700),),
          ),
        ],
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WorkoutInformation(activities: widget.activities, workoutId: widget.workoutId,)),
        );
      },
    );
  }
}