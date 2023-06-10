import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/Reservation/EquipmentResView.dart';
import 'package:us_rowing/widgets/AddedMenuButton.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class ClubResWidget extends StatefulWidget {
  final String clubName;
  final String image;
  final String clubId;
  final ClubModel clubModel;
  final String userId;

  ClubResWidget({this.image='',required this.clubName,required this.clubId,required this.clubModel, required this.userId});

  @override
  _ClubResWidgetState createState() => _ClubResWidgetState();
}

class _ClubResWidgetState extends State<ClubResWidget> {
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
                    child: Text(widget.clubName,maxLines: 2,overflow: TextOverflow.fade,textAlign: TextAlign.start,),
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
                builder: (context) => EquipmentResView(clubName: widget.clubName, clubId: widget.clubId,userId: widget.userId,)),
          );
        },
      ),
    );
  }
}

