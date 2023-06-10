
import 'package:flutter/material.dart';
import 'package:us_rowing/models/EqCategoryModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
class CategoryWidget extends StatelessWidget {

  final int index;
  final int last;
  final EqCategoryModel category;
  final int selected;

  CategoryWidget({required this.index,required this.last,required this.category, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(left: index==0?22:5,right: index==last?22:0),
      decoration: BoxDecoration(color: index==selected?colorPrimary:colorPrimary.withOpacity(0.1),borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Center(
        child: Text(category.categoryName,style: TextStyle(color: index==selected?colorWhite:colorPrimary),maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),
    );
  }
}
