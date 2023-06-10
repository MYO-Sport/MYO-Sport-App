import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class PhotoGridFile extends StatefulWidget {
  final int maxImages;
  final List<File> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  PhotoGridFile(
      {required this.imageUrls,
        required this.onImageClicked,
        required this.onExpandClicked,
        this.maxImages = 4,
      });

  @override
  createState() => _PhotoGridFileState();
}

class _PhotoGridFileState extends State<PhotoGridFile> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView(
      primary: false,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,

      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      File imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.file(imageUrl,fit: BoxFit.cover,),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.file(imageUrl,fit: BoxFit.cover,),
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.file(imageUrl,fit: BoxFit.cover,),
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}