
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';

class SimpleTimeField extends StatelessWidget{

  final String text;
  final TextEditingController  controller;
  final bool enabled;

  SimpleTimeField({this.text='',required this.controller,this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: TextField(
                onChanged: (value){
                  print('value:'+value);

                },
                enabled: enabled,
                inputFormatters: [DecimalTextInputFormatter()],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: text,
                  hintStyle: TextStyle(color: colorGrey,fontSize: 14),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorBlue)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorBlue)),
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorBlue)),
                  contentPadding: EdgeInsets.only(top: 15.0),
                ),
              ))
        ],
      ),
    );
  }

}