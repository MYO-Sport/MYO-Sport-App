import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class WorkOutWidget extends StatelessWidget {
  final String image;
  final String countDown;
  final String workout;
  final String unit;

  WorkOutWidget({required this.image,this.countDown='',required this.workout,this.unit=''});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 2,
      color: colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child: Image.asset(image),width: 30.0,height: 30.0,),
            SizedBox(height: 5.0),
            Text(workout,style: TextStyle(fontSize: 16.0,color: colorGrey),),
            SizedBox(height: 5.0),
            Flexible(child: Text(getCount(),style: TextStyle(color: colorBlack,fontSize: 20),maxLines: 1,)),
            Flexible(child: Text(unit,style: TextStyle(color: colorGrey,fontSize: 12),maxLines: 1,)),
          ],
        ),
      ),
    );
  }

  String getCount(){
    if(countDown.isEmpty || countDown=='NaN'){
      return '0';
    }
    return countDown;
  }
}