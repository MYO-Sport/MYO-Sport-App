
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class TagWidget extends StatelessWidget {

  final int index;
  final int last;
  final String title;
  final Function onRemove;

  TagWidget({required this.index,required this.last,required this.title, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(left: index==0?10:5,right: index==last?10:0),
      decoration: BoxDecoration(color: colorPrimary.withOpacity(0.1),borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,style: TextStyle(color: colorPrimary,fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,),
            SizedBox(width: 5,),
            InkWell(
              child: Container(height: 20,width: 20,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Icon(Icons.close,color: colorWhite,size: 15,)),
              ),
              onTap: (){
                onRemove();
              },
            ),
          ],
        ),
      ),
    );
  }
}
