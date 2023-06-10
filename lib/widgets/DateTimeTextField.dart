import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class DateTimeTextField extends StatelessWidget {
  final String text;
  final TextInputType type;
  final TextEditingController? controller;
  final bool enabled;
  final VoidCallback onTap;

  DateTimeTextField({required this.text,this.enabled=true,this.controller,this.type=TextInputType.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: colorWhite,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          keyboardType: TextInputType.datetime,
          style: TextStyle(
            color: colorBlack,
            fontFamily: 'Montserrat',
          ),
          textAlign: TextAlign.start,
          cursorColor: colorPrimary,
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.keyboard_arrow_down,color: colorGrey,),
            prefixIcon: Icon(Icons.calendar_today_outlined,color: colorGrey,),
            counterText: '',
            isDense: true,
            hintText: text,
            hintStyle: TextStyle(color: colorGrey, fontSize: 14,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorBlue,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorWhite,
              ),
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
