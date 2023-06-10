import 'package:flutter/material.dart';
import 'package:us_rowing/models/CoachModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Coach/MyCoach/MyCoachInfo.dart';

class CoachesDetails extends StatefulWidget {
  final String coachesName;
  final String coachesImage;
  final CoachModel coachModel;

  CoachesDetails({this.coachesName = '',this.coachesImage='',required this.coachModel});

  @override
  _CoachesDetailsState createState() => _CoachesDetailsState();
}

class _CoachesDetailsState extends State<CoachesDetails> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    int _tabIndex = 5;

    var tab = TabController(
        initialIndex: 5,
        length: 6,
        vsync: this
    );

    void _handleTabSelection(){
      setState(() {
        tab.index = _tabIndex;
      });
    }
    tab.addListener(_handleTabSelection);

    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: mColorSwatch,
        primaryColor: colorPrimary,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,

        fontFamily: 'Circular',

      ),
      home: DefaultTabController(
        initialIndex: 5,
        length: 6,
        child: Scaffold(
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
                    padding:  EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorWhite,
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  title: Padding(
                    padding:  EdgeInsets.only(top: 20.0),
                    child: Text(widget.coachesName),
                  ),
                  centerTitle: true,
                  bottom: TabBar(
                    controller: tab,
                    tabs: [
                      GestureDetector(
                        child: Tab(
                          icon: Container(
                            padding: EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/top-bar-feed-icon.png',
                              color: colorGrey,
                            ),
                          ),
                        ),
                        onTap: (){
                          _tabIndex = 5;
                        },
                      ),
                      GestureDetector(
                        child: Tab(
                          icon: Container(
                            padding: EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/top-bar-library-icon.png',
                              color: colorGrey,
                            ),
                          ),
                        ),
                        onTap: (){
                          _tabIndex = 5;
                        },
                      ),
                      GestureDetector(
                        child: Tab(
                          icon: Container(
                            padding: EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/top-bar-chat-icon.png',
                              color: colorGrey,
                            ),
                          ),
                        ),
                        onTap: (){
                          _tabIndex = 5;
                        },
                      ),
                      GestureDetector(
                        child: Tab(
                          icon: Container(
                            padding: EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/top-bar-event-icon.png',
                              color: colorGrey,
                            ),
                          ),
                        ),
                        onTap: (){
                          _tabIndex = 5;
                        }
                      ),
                      GestureDetector(
                        child: Tab(
                          icon: Container(
                            padding: EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/top-bar-team-icon.png',
                              color: colorGrey,
                            ),
                          ),
                        ),
                        onTap: (){
                          _tabIndex = 5;
                        },
                      ),
                      Tab(
                        icon: Container(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/images/top-bar-info-icon.png',
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
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              MyCoachInfo(coachModel: widget.coachModel,coachImage: widget.coachesImage,)
            ],
          ),
        ),
      ),
    );
  }
}
