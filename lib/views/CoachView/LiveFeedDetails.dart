import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/CoachView/fragments/FeedsCoach/CoachFeed1.dart';
import 'package:us_rowing/views/CoachView/fragments/FeedsCoach/CoachFeed2.dart';
import 'package:us_rowing/views/CoachView/fragments/FeedsCoach/CoachFeed3.dart';
import 'package:us_rowing/views/CoachView/fragments/FeedsCoach/CoachFeed4.dart';
import 'package:us_rowing/views/CoachView/fragments/FeedsCoach/CoachFeed5.dart';

class LiveFeedDetails extends StatefulWidget {
  @override
  _LiveFeedDetailsState createState() => _LiveFeedDetailsState();
}

class _LiveFeedDetailsState extends State<LiveFeedDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: colorBlack,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            child: Container(
              child: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight : Radius.circular(20.0)),
                ),
                backgroundColor: colorPrimary,
                leading: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: colorWhite,
                      size: 18
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text('Live Feeds',style:TextStyle(fontSize: 18)),
                ),
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          child: Image.asset(
                            IMG_FEED1,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          child: Image.asset(
                            IMG_FEED2,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          child: Image.asset(
                            IMG_FEED3,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Column(
                        children: <Widget>[
                          Container(
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              child: Image.asset(
                                IMG_FEED_LIVE,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              child: Container(
                                width: 24.0,
                                height: 24.0,
                                child: Image.asset(
                                  IMG_FEED4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          child: Image.asset(
                            IMG_FEED5,
                          ),
                        ),
                      ),
                    ),
                  ],
                  isScrollable: false,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            CoachFeed1(),
            CoachFeed2(),
            CoachFeed3(),
            CoachFeed4(),
            CoachFeed5(),
          ],
        ),
      ),
    );
  }
}
