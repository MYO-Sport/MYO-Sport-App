
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'SimpleToolbar.dart';



class ZoomImage extends StatelessWidget {
  final String url;
  static const String id = "ZoomImage";

  ZoomImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: SimpleToolbar(title: 'Image Viewer'),
      body: new ZoomImageScreen(url: url),
    );
  }
}

class ZoomImageScreen extends StatefulWidget {
  final String url;

  ZoomImageScreen({required this.url});

  @override
  State createState() => new ZoomImageScreenState(url: url);
}

class ZoomImageScreenState extends State<ZoomImageScreen> {
  final String url;

  ZoomImageScreenState({required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widgetFullPhoto(context, url);
  }

  static Widget widgetFullPhoto(BuildContext context, String url) {
    return Container(child: PhotoView(imageProvider: NetworkImage(url)));
  }
}