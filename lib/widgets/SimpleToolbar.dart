
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class SimpleToolbar extends PreferredSize{

  final bool isBack;
  final String title;

  SimpleToolbar({this.isBack=true,required this.title}) : super(preferredSize: Size.fromHeight(60),child: SizedBox());


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorWhite,
      title: Text(
        title,
        style: TextStyle(color: colorBlack),
      ),
      centerTitle: true,
      leading:
      isBack?
      InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: colorPrimary,
          size: 18,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ):SizedBox(),
    );
  }

}