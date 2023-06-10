import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Team/MyTeam/MyTeamDetails.dart';
import 'package:us_rowing/widgets/AddedMenuButton.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class MyTeamWidget extends StatefulWidget {
  final String name;
  final String image;
  final String teamId;
  final TeamModel teamModel;
  final String userId;

  MyTeamWidget({this.image='',this.name='',required this.teamId,required this.teamModel, required this.userId});

  @override
  _MyTeamWidgetState createState() => _MyTeamWidgetState();
}

class _MyTeamWidgetState extends State<MyTeamWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
      child: InkWell(
        child: Material(
          color: colorWhite,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: colorLightGrey,
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: CachedImage(image: widget.image,radius: 0,fit: BoxFit.fill,padding: 0,
                      )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(widget.name,maxLines: 2,overflow: TextOverflow.fade,textAlign: TextAlign.start,),
                  )),
                  AddedMenuButton(text: 'ADDED', onPressed: (){

                  })
                ],
              ),
            ),
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyTeamDetails(teamName : widget.name , teamImage: widget.image,teamId: widget.teamId,teamModel: widget.teamModel,userId: widget.userId,)),
          );
        },
      ),
    );
  }
}

