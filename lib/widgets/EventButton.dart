
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class EventButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String text;
  final bool checked;

  EventButton(
      {
        required this.icon,
        required this.text,
        required this.onPressed,
        required this.checked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 96,
      child: MaterialButton(
        onPressed: onPressed,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: checked?colorBackButton:colorWhite,
              borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: checked?colorBackButton:colorGrey,width: 0.5),
          ),

          child: Container(
            constraints: BoxConstraints(maxWidth: 96, minHeight: 27),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,size: 12,color: checked?colorWhite:colorTextSecondary,),
                SizedBox(width: 5,),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: checked?colorWhite:colorTextSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
