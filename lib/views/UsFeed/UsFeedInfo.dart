
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/InfoMemberWidget.dart';

class UsFeedInfo extends StatefulWidget {
  final String clubImage;

  UsFeedInfo({this.clubImage = ''});

  @override
  _UsFeedInfoState createState() => _UsFeedInfoState();
}

class _UsFeedInfoState extends State<UsFeedInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.only(left: 0.0,right: 0.0, top: 28.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CachedImage(
                      image: widget.clubImage,
                      placeHolder: IMG_INFO,
                      radius: 100,
                      imageHeight: 60,
                      imageWidth: 60,
                    ),
                    Flexible(
                      child: Text(
                        'MYOSPORT FEED',
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),*/
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About Us',
                            style: TextStyle(
                                color: colorBlack,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(height: 0,color: colorGrey,),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'USRowing is a nonprofit membership organization recognized by the United States Olympic Committee as the national governing body for the sport of rowing in the United States. USRowing selects, trains and manages the teams that represent the U.S. in international competition including the world championships, Pan American Games and Olympics. More than 83,000 individuals and 1,350 organizations strong, USRowing serves and promotes the sport on all levels of competition. USRowing membership reflects the spectrum of American rowers-juniors, collegians, masters and those who row for recreation, competition or fitness.',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: colorGrey),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Members('+usMembers.length.toString()+')',
                            style: TextStyle(
                                color: colorBlack,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(height: 0,color: colorGrey,),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: usMembers.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                String name = usMembers[index];
                                // String image= usMemberImages[index];
                                index = index + 1;
                                return InfoMemberWidget(image: '', name: name);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Contact Details',
                            style: TextStyle(
                                color: colorBlack,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),

                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(height: 0,color: colorGrey,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email',
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),

                          Text(
                            'members@usrowing.org',
                            style: TextStyle(
                                fontSize: 11.0,
                                color: colorBlack),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CITY',
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                        'Princeton',
                        style: TextStyle(
                            fontSize: 11.0,
                            color: colorBlack),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'LOCATION',
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '252 Nassau St.Princeton, NJ 08542',
                            style: TextStyle(
                                fontSize: 11.0,
                                color: colorBlack),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ASSOCIATIONS',
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1. Olympians and Paralympians Association\n2. Small Club Saturdays: Tulsa Youth Rowing Association',
                            style: TextStyle(
                                fontSize: 11.0,
                                color: colorBlack),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
