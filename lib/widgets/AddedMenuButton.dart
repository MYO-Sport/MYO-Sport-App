import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class AddedMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double radius;
  final double height;
  final double width;

  AddedMenuButton(
      {required this.text, required this.onPressed, this.radius = 17.0, this.width = 73.0, this.height = 24.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
             color: colorLightGrey,
              borderRadius: BorderRadius.circular(radius)
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: width, minHeight: height),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorBlack,
                fontSize: 11.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}