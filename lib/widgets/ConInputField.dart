
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class ConInputField extends StatelessWidget{

  final String text;
  final TextEditingController?  controller;
  final bool enabled;
  final int maxLength;

  ConInputField({this.text='',this.controller,this.enabled=true,this.maxLength=2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: TextField(
                enabled: enabled,
                onChanged: (value){
                  if(maxLength==2 && value.length==1 && int.parse(value)>=6){
                    controller!.text='0$value';
                    controller!.selection = TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
                  }
                },
                keyboardType: TextInputType.number,
                controller: controller,
                maxLength: maxLength,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: text,
                  hintStyle: TextStyle(color: colorGrey,fontSize: 14),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: ''
                ),
              ))
        ],
      ),
    );
  }

}