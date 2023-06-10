

import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:us_rowing/views/AtheleteDetailView.dart';

import 'CachedImage.dart';

class TeamMemberWidget extends StatelessWidget{

  final String name;
  final String image;
  final String email;
  final String id;
  final String userId;
  final String type;

  TeamMemberWidget({required this.name,required this.image,required this.email,required this.id,required this.userId,required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0),
      child: InkWell(
        child: Container(
          height: 50,
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: colorWhite,
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
                ApiClient.baseUrl + image,
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
                      name,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: colorBlack),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      type,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 10.0,
                          color: colorTextSecondary),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,color: colorGrey, size: 16,)
            ],
          ),
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AthleteDetailView(athleteName: name,img: image,email: email,athleteId: id,userId: userId,)));
        },
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