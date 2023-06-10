import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class HeadValueWidget extends StatelessWidget {
  final String title;
  final String value;

  HeadValueWidget({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colorBlue, width: 0.5))),
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 14, color: colorGrey),
                  )),
              Expanded(
                flex: 1,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorGrey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
