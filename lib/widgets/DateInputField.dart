

import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

import 'SimpleInputField.dart';

class DateInputField extends StatelessWidget{

  final String heading;
  final TextEditingController?  controller;
  final VoidCallback onTap;

  DateInputField({this.heading='',this.controller,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(left: 15.0,right:15,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                heading,
                style: TextStyle(fontSize: 12.0,color: colorBlack),
              ),
            ),
            SizedBox(height: 5,),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: colorWhite,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child:
                Row(
                  children: [
                    Expanded(
                      child: SimpleInputField(
                        text: 'Enter '+heading,
                        controller: controller,
                        enabled: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.calendar_today_outlined,color: colorGrey,size: 24,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

}