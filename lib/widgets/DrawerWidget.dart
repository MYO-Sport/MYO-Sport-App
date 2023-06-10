

import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class DrawerWidget extends StatelessWidget{

  final String name;
  final String icon;
  final Function onTap;

  DrawerWidget({required this.name, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 24,
              height: 24,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14.0,
                  color: colorBlack,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,color: colorPrimary,size: 15,),
          ],
        ),
      ),
      onTap: (){
        onTap();
      },
    ) ;
  }

}