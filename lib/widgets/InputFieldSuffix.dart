
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class InputFieldSuffix extends StatelessWidget {
  final String text;
  final bool obscureText;
  final TextInputType type;
  final TextEditingController? controller;
  final String suffixImage;
  final Function onChange;

  InputFieldSuffix(
      {this.text = '',
      this.obscureText = false,
      this.type = TextInputType.text,
      this.controller,
      this.suffixImage = '',
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5.0),
      child: Material(
        color: colorWhite,
        borderRadius: BorderRadius.circular(40.0),
        child: TextField(
          keyboardType: type,
          obscureText: obscureText,
          controller: controller,
          autocorrect: false,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: Container(
                padding: EdgeInsets.all(12.0),
                child: Image.asset(suffixImage, width: 5.0, height: 5)),
            hintText: text,
            hintStyle: TextStyle(color: colorGrey, fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorTransparent,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorTransparent,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            contentPadding:
                EdgeInsets.only(right: 20.0, left: 20.0),
          ),
          // onChanged: (text){
          //   onChange(text);
          // },
          onSubmitted: (text){
            onChange(text);
          },
        ),
      ),
    );
  }
}
