import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AtheleteDetailView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class MemberWidget extends StatelessWidget {

  final String name;
  final String image;
  final String email;
  final String userId;
  final String id;


  MemberWidget({required this.image, required this.name,required this.email, required this.userId, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CachedImage(
                image:
                    ApiClient.baseUrl+image,
                imageHeight: 80.0,
                radius: 15,
                imageWidth: 80,
              ),
              Text(
                name,
                style:
                    TextStyle(color: colorBlack, fontWeight: FontWeight.bold),
              ),
              MaterialButton(
                  height: 20,
                  minWidth: 30,
                  color: colorBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'DETAIL',
                    style: TextStyle(color: colorWhite, fontSize: 12,fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AthleteDetailView(athleteName: name,email: email,img: image,athleteId: id,userId: userId,)));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
