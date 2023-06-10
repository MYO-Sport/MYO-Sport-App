import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class MainWidget extends StatelessWidget {
  final String preImage;
  final String postImage;
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressed;

  MainWidget(
      {required this.text, required this.postImage, required this.preImage,required this.onPressed, this.height = 35.0, this.width = 35.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: colorBlue, width: 1))),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 10.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(preImage, width: width, height: height,color: colorImage,),
                Text(text, style: TextStyle(fontSize: 20.0),),
                Image.asset(postImage, width: width, height: height,),
              ],
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}