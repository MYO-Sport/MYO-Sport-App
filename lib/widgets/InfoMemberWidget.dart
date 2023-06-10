import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class InfoMemberWidget extends StatelessWidget {

  final String name;
  final String image;
  InfoMemberWidget({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CachedImage(
          image:
          ApiClient.baseUrl+image,
          imageHeight: 60.0,
          radius: 8,
          imageWidth: 60,
        ),
        SizedBox(height: 10,),
        Text(
          name,
          style:
          TextStyle(color: colorBlack, fontSize: 8),
        ),
      ],
    );
  }
}
