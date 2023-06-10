import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

import 'AddedMenuButton.dart';

class AddedEventWidget extends StatelessWidget {
  final String date;
  final String day;
  final String time;
  final String sport;
  final String state;
  final String description;
    AddedEventWidget({this.date='',this.day='',this.description='',this.time='',this.sport='',this.state=''});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 3.0,),
                          Text(
                            day,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                      color: colorLightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    width: 70.0,
                    height: 70.0,
                  ),
                  SizedBox(width: 20.0,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(time,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0),),
                        SizedBox(height: 5.0,),
                        Text(sport,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.0,color: colorGrey),),
                        Text(state,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.0,color: colorGrey),),
                      ],
                    ),
                  ),
                  AddedMenuButton(text: 'ADDED', onPressed: (){})
                ],
              ),
              SizedBox(height: 8.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: colorGrey,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}