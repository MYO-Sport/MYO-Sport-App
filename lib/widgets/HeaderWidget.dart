import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class HeaderWidget extends StatelessWidget{

  final String text;

  HeaderWidget({this.text=''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 32),
      child: Text(text,style: TextStyle(color: colorBlack,fontWeight: FontWeight.bold,fontSize: 18),),
    );
  }

}