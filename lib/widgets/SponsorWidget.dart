import 'package:flutter/material.dart';
import 'package:us_rowing/models/SponsorModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/SponsorDetailView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class SponsorWidget extends StatelessWidget {
  final SponsorModel sponsor;

  SponsorWidget({required this.sponsor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 10.0,right: 10,left: 10),
      child: InkWell(
        child: Material(
          elevation: 0,
          color: colorWhite,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CachedImage(image: ApiClient.baseUrl+sponsor.image,imageHeight: 70.0,radius: 15,imageWidth: 70,padding: 0,),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(sponsor.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                      SizedBox(height: 8.0,),
                      Text(sponsor.description,style: TextStyle(color: colorGrey,fontSize: 12.0,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Icon(Icons.arrow_forward_ios,color: colorPrimary,)
                
              ],
            ),
          ),
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SponsorDetailView(sponsor: sponsor)));
        },
      ),
    );
  }
}