import 'package:flutter/material.dart';
import 'package:us_rowing/models/club/club_response.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Club/MyClub/MyClubDetails.dart';
import 'package:us_rowing/widgets/AddedMenuButton.dart';
import 'package:us_rowing/widgets/CachedImage.dart';



class MyClubWidget extends StatefulWidget {
  final String name;
  final String image;
  final String clubId;
  final AllClub clubModel;
  final String userId;

  MyClubWidget({this.image='',this.name='',required this.clubId,required this.clubModel, required this.userId});

  @override
  _MyClubWidgetState createState() => _MyClubWidgetState();
}

class _MyClubWidgetState extends State<MyClubWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
      child: InkWell(
        child: Material(
          color: colorWhite,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.all(10),
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
                  AddedMenuButton(text: 'Added', onPressed: (){
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
                builder: (context) => MyClubDetails(clubName: widget.name,clubImage: widget.image,clubId: widget.clubId,clubModel: widget.clubModel,userId: widget.userId,)),
          );
        },
      ),
    );
  }
}

