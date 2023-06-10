import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Team/MyTeam/MyTeamInfo.dart';

class TeamDetails extends StatefulWidget {
  final String teamName;
  final String teamImage;
  final TeamModel teamModel;

  TeamDetails({this.teamName = '',this.teamImage='',required this.teamModel});

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> with TickerProviderStateMixin {
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
            child: Container(
              child: AppBar(
                backgroundColor: colorWhite,
                title: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: colorWhite,
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                      Row(children: [
                        Image.asset(IMG_TEAMS,height: 20,width: 20,color: colorWhite,),
                        SizedBox(width: 10,),
                        Text(widget.teamName),
                      ], ),
                      SizedBox(height: 24,width: 24,)
                    ],
                  ),
                ),
                centerTitle: true,
                bottom: TabBar(
                  unselectedLabelColor: colorGrey,
                  labelColor: colorPrimary,
                  unselectedLabelStyle: TextStyle(color: colorGrey,fontSize: 14),
                  labelStyle: TextStyle(color: colorPrimary,fontSize: 14),
                  indicatorColor: colorPrimary,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorWeight: 2,
                  indicator: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/tab_background.png'),fit: BoxFit.fill),
                  ),
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
                            IMG_ATHLETES,
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
                          color: colorPrimary,
                        ),
                      ),
                    ),
                  ],
                  isScrollable: false,
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
              MyTeamInfo(teamModel: widget.teamModel,teamImage: widget.teamImage,),
            ],
          ),
        ),
      ),
    );
  }
}
