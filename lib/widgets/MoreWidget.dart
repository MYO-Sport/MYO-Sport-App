
import 'package:flutter/material.dart';

import 'package:us_rowing/utils/AppColors.dart';

class MoreWidget extends StatelessWidget {
  
  final String image;
  final String head;
  final String desc;
  
  MoreWidget({required this.image,required this.head, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
            children: [
              Image.asset(image,height: 18,width: 18,),
              Flexible(child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(head,style: TextStyle(color: colorBlack,fontSize: 14),maxLines: 1,),
                    SizedBox(height: 5,),
                    Text(desc,style: TextStyle(color: colorTextSecondary,fontSize: 10),maxLines: 1,)
                  ],
                ),
              ))
            ],
        )
    );
  }
}

