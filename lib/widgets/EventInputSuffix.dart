
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class EventInputSuffix extends StatelessWidget {
  final String text;
  final TextInputType type;
  final TextEditingController? controller;
  final bool enabled;
  final int maxLength;
  final String suffixImage;

  EventInputSuffix({
    this.text = '',
    this.type = TextInputType.text,
    this.controller,
    this.enabled = true,
    this.maxLength = 20,
    this.suffixImage = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: TextFormField(
        enabled: enabled,
        keyboardType: type,
        controller: controller,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        maxLength: maxLength,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          suffixIcon: Container(
              padding: EdgeInsets.all(15.0),
              child: Image.asset(suffixImage, width: 5.0, height: 5)),
          counterText: '',
          isDense: true,
          hintText: text,
          hintStyle: TextStyle(
            color: colorGrey,
            fontSize: 14,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorGrey,
            ),
          ),
        ),
      ),
    );
  }
}
