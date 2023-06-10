
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';

class SimpleInputField extends StatelessWidget{

  final String text;
  final TextEditingController?  controller;
  final bool enabled;

  SimpleInputField({this.text='',this.controller,this.enabled=true});

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
                enabled: enabled,
                inputFormatters: [DecimalTextInputFormatter()],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: controller,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: text,
                  hintStyle: TextStyle(color: colorGrey,fontSize: 14),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
        ],
      ),
    );
  }

}