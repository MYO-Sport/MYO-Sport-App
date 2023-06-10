import 'dart:convert';
import 'package:http/http.dart' as http;
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

class MyTeamFeed extends StatefulWidget {
  final String teamName;
  final String teamImage;
  final String teamId;
  final bool isAdmin;
  final bool isModerator;
  MyTeamFeed({this.teamName='',this.teamImage='',required this.teamId, required this.isAdmin, required this.isModerator});
  @override
  _MyTeamFeedState createState() => _MyTeamFeedState();
}

class _MyTeamFeedState extends State<MyTeamFeed> {

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
        getTeamsFeed(++skip);
      }
    });

    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getTeamsFeed(skip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          widget.isModerator || widget.isAdmin?
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 10),
            child: InkWell(
              child: Container(
                height: 40,
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: colorWhite),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Post in feed',
                      style: TextStyle(color: colorGrey),
                    ),
                    Container(
                        width: 30.0,
                        height: 30.0,
                        child: Icon(
                          Icons.camera_alt,
                          color: colorGrey,
                        )),
                  ],
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
                            type: typeTeam,
                            id: widget.teamId,
                            onAdd: onAdd,
                          ),
                          height: MediaQuery.of(context).size.height * 0.8,
                        ),
                      ],
                    ));
              },
            ),
          ):SizedBox(),
          isLoading
              ? Expanded(
              child: Center(child: CircularProgressIndicator()))
              : feeds.length == 0
              ? Expanded(
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
                      isAdmin: widget.isAdmin,
                      onRefresh: (){
                        setState(() {
                          isLoading = true;
                          skip=0;
                        });
                        getTeamsFeed(0);
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
    getTeamsFeed(0);
  }

  getTeamsFeed(int skip) async {
    if (skip == 0) {
      setState(() {
        isLoading = true;
      });
    }else{
      setState(() {
        moreLoadingg=true;
      });
    }
    String apiUrl = ApiClient.urlGetTeamFeeds;

    print('Club ID: ' + widget.teamId);
    print('User ID: ' + userId);
    print('skip: ' + skip.toString());
    print('limit: ' + limit);
    final response = await http.post(Uri.parse(apiUrl), body: {
      'creater_id': widget.teamId,
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
