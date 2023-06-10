import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/LikeModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/LikesResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:http/http.dart' as http;

class ViewLikesWidget extends StatefulWidget {

  final String postId;

  ViewLikesWidget({required this.postId});

  @override
  _ViewLikesWidgetState createState() => _ViewLikesWidgetState();
}

class _ViewLikesWidgetState extends State<ViewLikesWidget> {
  List<LikeModel> likes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLikes();
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
          children: [
            Material(
              color: colorWhite,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(child: Icon(Icons.arrow_back_ios),onTap: (){
                      Navigator.pop(context);
                    },),
                    Text(
                      'Likes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          letterSpacing: 1.0),
                    ),
                    Text(
                      'Likes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: colorWhite,
                          letterSpacing: 1.0
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            isLoading
                ? Expanded(
                child: Center(child: CircularProgressIndicator()))
                : likes.length == 0
                ? Expanded(
              child: Center(
                  child: Text(
                    'No Likes',
                    style: TextStyle(color: colorGrey),
                  )),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: likes.length,
                itemBuilder: (context , index){
                  LikeModel like = likes[index];
                  if(like.likedBy.length!=0){
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CachedImage(image: '',imageHeight: 50.0,radius: 25.0,imageWidth: 50,),
                              SizedBox(width: 20.0,),
                              Flexible(child: Text(like.likedBy[0].username,style: TextStyle(fontSize: 14.0),)),
                            ],
                          ),
                          Divider(color: colorGrey,thickness: 0.2,),
                        ],
                      ),
                    );
                  }else{
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLikes() async {
    print('postId: ' + widget.postId);
    String apiUrl = ApiClient.urlGetLikes+widget.postId ;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      LikesResponse mResponse =
      LikesResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          likes=mResponse.post;
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading=false;
        });
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      print('Error: ' + 'Check Your Internet Connection');
    }
  }
}