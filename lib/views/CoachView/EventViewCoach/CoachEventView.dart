import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/CoachView/EventViewCoach/EventViewDetails.dart';


class CoachMyEventView extends StatefulWidget {

  final String userId;

  CoachMyEventView({required this.userId});

  @override
  _CoachMyEventViewState createState() => _CoachMyEventViewState();
}

class _CoachMyEventViewState extends State<CoachMyEventView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    int _tabIndex = 3;

    var tab = TabController(
        initialIndex: 3,
        length: 5,
        vsync: this
    );

    void _handleTabSelection(){
      setState(() {
        tab.index = _tabIndex;
      });
    }
    tab.addListener(_handleTabSelection);
    return Scaffold(
      bottomNavigationBar: Container(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('You can create new events by going to teams and clubs.',style: TextStyle(color: colorWhite,),textAlign: TextAlign.center,),
          )),
      body: Stack(
        children: [
          DefaultTabController(
            length: 5,
            initialIndex: 3,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('EVENTS'),
                      ),
                      centerTitle: true,
                      bottom: TabBar(
                        controller: tab,
                        tabs: [
                          GestureDetector(
                            child: Tab(
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/top-bar-feed-icon.png',
                                  color: colorGrey,
                                ),
                              ),
                            ),
                            onTap: (){
                              _tabIndex = 3;
                            },
                          ),
                          GestureDetector(
                            child: Tab(
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/top-bar-library-icon.png',
                                  color: colorGrey,
                                ),
                              ),
                            ),
                            onTap: (){
                              _tabIndex = 3;
                            },
                          ),
                          GestureDetector(
                            child: Tab(
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/top-bar-chat-icon.png',
                                  color: colorGrey,
                                ),
                              ),
                            ),
                            onTap: (){
                              _tabIndex = 3;
                            },
                          ),
                          Tab(
                            icon: Container(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/top-bar-event-icon.png',
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Tab(
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/top-bar-info-icon.png',
                                  color: colorGrey,
                                ),
                              ),
                            ),
                            onTap: (){
                              _tabIndex = 3;
                            },
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
                  Container(),
                  Container(),
                  Container(),
                  EventViewDetails(userId:widget.userId),
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
