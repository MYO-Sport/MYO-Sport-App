import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';

class CachedImage extends StatelessWidget {
  final String image;
  final double radius;
  final double imageWidth;
  final double imageHeight;
  final double imageArea;
  final double padding;
  final BoxFit fit;
  final String placeHolder;
  CachedImage({this.image='',this.radius=30,this.imageHeight=70,this.imageWidth=70,this.imageArea=30,this.padding=5.0,this.fit=BoxFit.cover,this.placeHolder=IMG_PLACEHOLDER});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(colorGrey),
                ),
              ),
              height: imageArea,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0))),
            ),
            errorWidget: (context, url, error) => Material(
              child: Padding(
                padding: placeHolder == WORKOUT_PLACEHOLDER ? EdgeInsets.all(8.0): EdgeInsets.all(0.0),
                child: Image.asset(
                  placeHolder,
                  width: placeHolder == WORKOUT_PLACEHOLDER ? 54.0 : 70.0,
                  height: placeHolder == WORKOUT_PLACEHOLDER ? 54.0 : 70.0,
                  fit: BoxFit.fill,
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              clipBehavior: Clip.hardEdge,
            ),
            imageUrl: image,
            width: imageWidth,
            height: imageHeight,
            fit: fit),
      ),
    );
  }
}