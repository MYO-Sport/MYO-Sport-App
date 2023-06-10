import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class AddMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double radius;
  final double height;
  final double width;
  final bool progress;

  AddMenuButton(
      {required this.text,
      required this.onPressed,
      this.radius = 17.0,
      this.width = 73.0,
      this.height = 24.0,
      this.progress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorStartGradient, colorEndGradient],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(radius)),
          child: Container(
            constraints: BoxConstraints(maxWidth: width, minHeight: height),
            alignment: Alignment.center,
            child: progress
                ? SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: 12.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
