import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AtheleteDetailView.dart';

class AthleteWidget extends StatelessWidget {
  final String name;
  final String image;
  final String email;
  final String id;
  final String userId;

  AthleteWidget({required this.name,required this.image,required this.email,required this.id,required this.userId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height,
                  placeholder: (context, url) => Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(colorGrey),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Image.asset(
                      "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                  imageUrl: ApiClient.baseUrl+image,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 2,),
          Text(name,style: TextStyle(color: colorGrey,fontSize: 10),textAlign: TextAlign.center,)

        ],
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AthleteDetailView(athleteName: name,img: image,email: email,athleteId: id,userId: userId,)));
      },
    );
  }
}