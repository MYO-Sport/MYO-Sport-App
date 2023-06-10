import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class FeedDetailView extends StatefulWidget {

  final List<String> imgList;

  FeedDetailView({required this.imgList});

  @override
  _FeedDetailViewState createState() => _FeedDetailViewState();
}

class _FeedDetailViewState extends State<FeedDetailView> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: SimpleToolbar(title: 'Image Viewer'),
      body: PageView.builder(
        itemCount: widget.imgList.length,
        itemBuilder: (context, index) {
          String image = widget.imgList[index];
          return Container(
            child: PhotoView.customChild(
              minScale: 1.0,
              maxScale: 3.0,
              backgroundDecoration: BoxDecoration(
                color: colorBlack,
              ),
              child: CachedImage(
                imageWidth: 0.0,
                imageHeight: 0.0,
                radius: 0.0,
                padding: 0,
                imageArea: 0.0,
                image: ApiClient.baseUrl+image,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
