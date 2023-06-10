import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double radius;
  final double height;
  final double width;
  final double fontSize;
  final Color startColor;
  final Color endColor;
  final Color textColor;

  SecondaryButton(
      {required this.text,
        required this.onPressed,
        this.radius = 30,
        this.textColor = colorBlack,
        this.width = 250,
        this.height = 60,
        this.fontSize = 14.0,
        this.endColor = colorTransparent,
        this.startColor = colorTransparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [startColor, endColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border.all(color: colorGrey,),
              borderRadius: BorderRadius.circular(radius)),
          child: Container(
            constraints: BoxConstraints(maxWidth: width, minHeight: height),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
