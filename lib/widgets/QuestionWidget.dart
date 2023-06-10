import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class QuestionWidget extends StatelessWidget{

  final String text;

  QuestionWidget({this.text=''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:18.0,right: 32),
      child: Text(text,style: TextStyle(color: colorBlack,fontWeight: FontWeight.bold),),
    );
  }

}