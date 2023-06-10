import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Club/MyClub/MyClubInfo.dart';

class ClubDetails extends StatefulWidget {
  final String clubName;
  final String clubImage;
  final ClubModel clubModel;
  final String userId;

  ClubDetails({this.clubName = '',this.clubImage='',required this.clubModel,required this.userId});

  @override
  _ClubDetailsState createState() => _ClubDetailsState();
}

class _ClubDetailsState extends State<ClubDetails> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    int _tabIndex = 4;

    var tab = TabController(
        initialIndex: 4,
        length: 5,
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
        initialIndex: 4,
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              child: AppBar(

                backgroundColor: colorWhite,
                leading: Padding(
                  padding:  EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: colorPrimary,
                      size: 18,
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: Padding(
                  padding:  EdgeInsets.only(top: 20.0),
                  child: Text(widget.clubName,style: TextStyle(color: colorBlack),),
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
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/top-bar-feed-icon.png',
                              color: Colors.grey
                          ),
                        ),
                      ),
                      onTap: (){
                        _tabIndex = 4;
                      },
                    ),
                    GestureDetector(
                      child: Tab(
                        icon: Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/top-bar-library-icon.png',
                              color: Colors.grey
                          ),
                        ),
                      ),
                      onTap: (){
                        _tabIndex = 4;
                      },
                    ),
                    // GestureDetector(
                    //   child: Tab(
                    //     icon: Container(
                    //       padding: EdgeInsets.all(10),
                    //       child: Image.asset(
                    //         'assets/images/top-bar-chat-icon.png',
                    //           color: Colors.grey
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: (){
                    //     _tabIndex = 5;
                    //   },
                    // ),
                    GestureDetector(
                      child: Tab(
                        icon: Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/top-bar-event-icon.png',
                              color: Colors.grey
                          ),
                        ),
                      ),
                      onTap: (){
                        _tabIndex = 4;
                      }
                    ),
                    GestureDetector(
                      child: Tab(
                        icon: Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/top-bar-team-icon.png',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onTap: (){
                        _tabIndex = 4;
                      },
                    ),
                    Tab(
                      icon: Container(
                        padding: EdgeInsets.all(10),
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
              // Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              MyClubInfo(clubImage: widget.clubImage,clubModel: widget.clubModel, userId: widget.userId,),
            ],
          ),
        ),
      ),
    );
  }
}
