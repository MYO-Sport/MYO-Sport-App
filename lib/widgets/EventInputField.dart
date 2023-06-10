
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class EventInputField extends StatelessWidget {
  final String text;
  final TextInputType type;
  final TextEditingController? controller;
  final bool enabled;
  final int maxLength;
  final int maxLines;
  final Color focusedBorderColor;
  final Color borderColor;

  EventInputField(
      {this.text = '',
      this.type = TextInputType.text,
      this.controller,
      this.enabled = true,
      this.maxLength = 20,
        this.focusedBorderColor = colorPrimary,
        this.borderColor = colorWhite,
      this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        cursorColor: colorPrimary,
        enabled: enabled,
        keyboardType: type,
        maxLines: maxLines,
        controller: controller,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        maxLength: maxLength,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          fillColor: colorPrimary,
          counterText: '',
          isDense: true,
          hintText: text,
          hintStyle: TextStyle(color: colorGrey, fontSize: 14,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: focusedBorderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: borderColor,
            ),
          )
        ),
      ),
    );
  }
}
