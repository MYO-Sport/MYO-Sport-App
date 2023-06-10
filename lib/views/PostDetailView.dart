import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/FeedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/PostResponse.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/FeedWidget.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:http/http.dart' as http;

class PostDetailView extends StatefulWidget {

  final String userId;
  final String postId;

  PostDetailView({required this.userId, required this.postId});

  @override
  _PostDetailViewState createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {


  bool isLoading=true;

  late FeedModel post;

  @override
  void initState() {
    super.initState();
    getHomeFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleToolbar(title: 'Post'),
      body:
      isLoading?
      Container(height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )  :
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            FeedWidget(
              feed: post,
              userId: widget.userId,
              isAdmin: false,
              onRefresh: (){

              },
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  getHomeFeeds() async {

    String apiUrl = ApiClient.urlGetPostDetail;
    print('User ID: ' + widget.userId);
    print('Post ID: ' + widget.postId);
    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'post_id': widget.postId,
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      PostResponse mResponse =
      PostResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          post = mResponse.post;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
