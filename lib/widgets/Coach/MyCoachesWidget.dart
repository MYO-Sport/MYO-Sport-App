import 'package:flutter/material.dart';
import 'package:us_rowing/models/CoachModel.dart';
import 'package:us_rowing/views/AthleteView/Coach/MyCoach/MyCoachDetails.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class MyCoachesWidget extends StatefulWidget {
  final String name;
  final String image;
  final String coachId;
  final CoachModel coachModel;
  final String roomId;

  MyCoachesWidget({this.image='',this.name='',required this.coachId,required this.coachModel,required this.roomId});

  @override
  _MyCoachesWidgetState createState() => _MyCoachesWidgetState();
}

class _MyCoachesWidgetState extends State<MyCoachesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
      child: InkWell(
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
                  CachedImage(image: widget.image,radius: 100,),
                  Flexible(child: Text(widget.name,maxLines: 2,overflow: TextOverflow.fade,textAlign: TextAlign.center,)),
                  SizedBox(width: 60.0,height: 60.0),
                ],
              ),
            ),
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyCoachDetails(coachName: widget.name,coachImage: widget.image,coachId:widget.coachId,coachModel: widget.coachModel,roomId:widget.roomId)),
          );
        },
      ),
    );
  }
}

