import 'dart:io';



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:us_rowing/utils/AppColors.dart';


class SelectImageSheet extends StatefulWidget {
  final Function onAdd;

  SelectImageSheet({required this.onAdd});

  @override
  _SelectImageSheetState createState() => _SelectImageSheetState();
}

class _SelectImageSheetState extends State<SelectImageSheet> {
  late File file;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: colorPrimary),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios,color: colorWhite,)),
                    Text(
                      'Select Image',
                      style: TextStyle(
                        color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(width: 24,)
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: colorGrey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                                'assets/images/image.png'),
                            width: 30.0,
                            height: 30.0,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                          Icon(
                            Icons.send,
                            color: colorGrey,
                          ),
                        ],
                      ),
                      onTap: () {
                        getImageFromGallery();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: colorGrey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                                'assets/images/video.png'),
                            width: 30.0,
                            height: 30.0,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                          Icon(
                            Icons.send,
                            color: colorGrey,
                          ),
                        ],
                      ),
                      onTap: () {
                        getImageFromCamera();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file=File(pickedFile.path);
        widget.onAdd(file);
        Navigator.pop(context);
      });
    } else {
      print('No Image selected');
      Navigator.pop(context);
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        file=File(pickedFile.path);
        widget.onAdd(file);
        Navigator.pop(context);
      });
    } else {
      print('No video selected');
      Navigator.pop(context);
    }
  }

}
