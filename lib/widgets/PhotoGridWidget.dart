import 'dart:math';

import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class PhotoGridWidget extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  PhotoGridWidget(
      {required this.imageUrls,
        required this.onImageClicked,
        required this.onExpandClicked,
        this.maxImages = 4,
        });

  @override
  createState() => _PhotoGridWidgetState();
}

class _PhotoGridWidgetState extends State<PhotoGridWidget> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView(
      primary: false,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.imageUrls.length==1?1:2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,

      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = ApiClient.baseUrl+widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: CachedImage(
              radius: 15,
              padding: 0,
              image: imageUrl,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedImage(
                  radius: 15,
                  padding: 0,
                  image: imageUrl,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: CachedImage(
            radius: 15,
            padding: 0,
            image: imageUrl,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}