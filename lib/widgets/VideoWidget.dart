
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';

class VideoWidget extends StatelessWidget {

  final bool showTitle;
  final double border;
  final double buttonSize;

  VideoWidget({this.showTitle=true,this.border=4,this.buttonSize=50});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: colorGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(border),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(IMG_TEST_2, fit: BoxFit.cover,)
              ),
            ),
            showTitle?
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:Container(
                  decoration: BoxDecoration(
                    color: colorBlack.withOpacity(0.8),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.all(10),
                  child:Center(child: Text('Coach New Video',style: TextStyle(color: colorWhite),)),
                )
            ):
            SizedBox(),
            Center(
              child: Container(
                height: buttonSize,
                width: buttonSize,
                decoration: BoxDecoration(
                  color: colorWhite.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(Icons.play_arrow,color: Colors.red,),
              ),
            )
          ],

        ),

      ),
    );
  }

}