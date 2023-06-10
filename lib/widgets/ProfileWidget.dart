

import 'package:flutter/cupertino.dart';
import 'package:us_rowing/utils/AppColors.dart';

class ProfileWidget extends StatelessWidget{

  final String heading;
  final String value;

  ProfileWidget({required this.heading,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorLightGrey,width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading,style: TextStyle(color: colorTextSecondary,fontSize: 10),),
          SizedBox(height: 5,),
          Text(value,style: TextStyle(color: colorTextSecondaryDark,fontSize: 12),)
        ],
      ),
    );
  }

}