import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/SlotModel.dart';
import 'package:us_rowing/utils/AppColors.dart';

class SlotWidget extends StatelessWidget{

  final SlotModel slot;
  final int index;
  final int selected;

  SlotWidget({required this.slot,required this.index, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: slot.status=='1'?colorGrey:selected==index?colorGreen:colorWhite,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: slot.status=='1'?colorGrey:selected==index?colorGreen:colorGrey)
      ),
      child: Center(child: Text(slot.slotTime,style: TextStyle(color: slot.status=='1'?colorBlack:selected==index?colorWhite:colorGrey,fontSize: 12),)),
    );
  }

}