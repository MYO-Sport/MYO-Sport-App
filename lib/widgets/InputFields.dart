
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class InputField extends StatelessWidget{

  final String text;
  final bool obscureText;
  final TextInputType type;
  final TextEditingController?  controller;
  final String image;
  final bool enabled;
  final int maxLength;

  InputField({this.text='',this.obscureText=false,this.type=TextInputType.text,this.controller,this.image='',this.enabled=true,this.maxLength=20});

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
                keyboardType: type,
                obscureText: obscureText,
                controller: controller,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                maxLength: maxLength,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(8),
                      child: Image.asset(image,width: 5.0,height: 5,color: colorBlue,)),
                  hintText: text,
                  hintStyle: TextStyle(color: colorGrey,fontSize: 14),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorBlue)),
                  contentPadding: EdgeInsets.only(top: 15.0),
                ),
              ))
        ],
      ),
    );
  }

}