import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class AnswerWidget extends StatelessWidget{

  final String text;

  AnswerWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 32),
      child: Text(text,style: TextStyle(color: colorGrey),),
    );
  }

}