import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:us_rowing/utils/AppColors.dart';

class ReadMoreWidget extends StatelessWidget {
  final String text;
  final int trimLines;
  ReadMoreWidget({this.text='',this.trimLines=4});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: 11.0, color: colorBlack),
      trimLines: trimLines,
      colorClickableText: colorBlue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: colorBlue),
    );
  }
}