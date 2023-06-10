import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/FeedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/FeedsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AddPostWidget.dart';
import 'package:us_rowing/widgets/FeedWidget.dart';
import 'package:http/http.dart' as http;

class MyCoachFeed extends StatefulWidget {
  final String coachName;
  final String coachImage;
  final String coachId;

  MyCoachFeed({this.coachName = '', this.coachImage = '',required this.coachId});

  @override
  _MyCoachFeedState createState() => _MyCoachFeedState();
}

class _MyCoachFeedState extends State<MyCoachFeed> {
  bool isLoading = true;
  bool moreLoadingg= false;
  List<FeedModel> feeds = [];
  late String userId;
  late ScrollController _scrollController;

  int skip = 0;
  String limit = '5';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print('scrolling');
      if (!moreLoadingg && _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Full Scrolled');
        getCoachFeed(++skip);
      }
    });

    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getCoachFeed(skip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: colorGrey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'What On Your Mind...',
                          style: TextStyle(color: colorGrey),
                        ),
                        Container(
                            width: 30.0,
                            height: 30.0,
                            child: Image.asset(
                              'assets/images/arrow.png',
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            bottom:
                            MediaQuery.of(context).viewInsets.bottom),
                        child: AddPostWidget(
                          type: typeCoach,
                          id: widget.coachId,
                          onAdd: onAdd,
                        ),
                        height: MediaQuery.of(context).size.height * 0.8,
                      ),
                    ],
                  ));
            },
          ),
          SizedBox(height: 10,),
          isLoading
              ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(child: CircularProgressIndicator()))
              : feeds.length == 0
              ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                  child: Text(
                    'No Feeds',
                    style: TextStyle(color: colorGrey),
                  )))
              : Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: feeds.length+1,
                itemBuilder: (context, index) {
                  if(index==feeds.length){
                    if(moreLoadingg){
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      return Padding(padding: EdgeInsets.symmetric(vertical: 15),child: Center(child: SizedBox(height:30,width: 30,child: CircularProgressIndicator())),);
                    }else{
                      return SizedBox();
                    }
                  }else{
                    FeedModel feed = feeds[index];
                    return FeedWidget(
                      feed: feed,
                      userId: userId,
                      isAdmin: false,
                      onRefresh: (){
                        setState(() {
                          isLoading = true;
                          skip=0;
                        });
                        getCoachFeed(0);
                      },
                    );
                  }

                }),
          ),
        ],
      ),
    );
  }

  onAdd() {
    print('On Add is called in my club feed');
    setState(() {
      isLoading = true;
    });
    getCoachFeed(0);
  }
  getCoachFeed(int skip) async {
    if (skip == 0) {
      setState(() {
        isLoading = true;
      });
    }else{
      setState(() {
        moreLoadingg=true;
      });
    }
    String apiUrl = ApiClient.urlGetCoachesFeeds;

    print('Coach ID: ' + widget.coachId);
    print('User ID: ' + userId);
    print('skip: ' + skip.toString());
    print('limit: ' + limit);
    final response = await http.post(Uri.parse(apiUrl), body: {
      'creater_id': widget.coachId,
      'user_id': userId,
      'skip': '$skip',
      'limit': limit
    }).catchError((value) {
      setState(() {
        isLoading = false;
        moreLoadingg=false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      FeedsResponse mResponse =
      FeedsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        if (skip == 0) {
          setState(() {
            feeds = mResponse.feed;
            isLoading = false;
          });
        } else {
          setState(() {
            feeds.addAll(mResponse.feed);
            moreLoadingg = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          moreLoadingg=false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
        moreLoadingg=false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    }
  }
}
