import 'package:flutter/material.dart';

import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final UserModel item;
  final ValueChanged<bool> isSelected;

  GridItem({required this.item, required this.isSelected,required this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected(isSelected);
          });
        },
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CachedImage(image: ApiClient.baseUrl+widget.item.profileImage,radius: 100,),
                      SizedBox(width: 10,),
                      Text(widget.item.username),
                    ],
                  ),
                  isSelected
                      ? Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                        ),
                      )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}