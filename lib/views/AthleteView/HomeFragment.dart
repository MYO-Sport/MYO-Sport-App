import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/models/FeedModel.dart';
import 'package:us_rowing/models/SponsorModel.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/HomePostResponse.dart';
import 'package:us_rowing/network/response/SponsorsResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AthleteView/Club/ClubView.dart';
import 'package:us_rowing/views/AthleteView/Coach/CoachesView.dart';
import 'package:us_rowing/views/AthleteView/Team/TeamView.dart';
import 'package:us_rowing/views/SponsorDetailView.dart';
import 'package:us_rowing/views/WorkOutView.dart';
import 'package:us_rowing/widgets/AthleteDrawerWidget.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/MainWidget.dart';
import 'package:us_rowing/widgets/PostWidget.dart';

class HomeFragment extends StatefulWidget {
  final UserModel userModel;

  HomeFragment({required this.userModel});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SponsorModel> sponsors = [];
  bool isLoading = true;
  bool isSponsorLoading = false;

  List<FeedModel> clubFeeds = [];
  List<FeedModel> teamFeeds = [];

  @override
  void initState() {
    super.initState();
    getHomeFeeds();
    getSponsors(widget.userModel.sId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AthleteDrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            color: colorPrimary,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: InkWell(
                    child: Image.asset(
                      IMG_MENU,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                  width: 30.0,
                  height: 30.0,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'MYO',
                        style: TextStyle(
                            color: colorWhite,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                      Text(
                        'SPORT',
                        style: TextStyle(
                            color: colorBlue,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.width * 0.52,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                    : Center(
                        child: GridView(
                          clipBehavior: Clip.none,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1),
                          children: [
                            clubFeeds.length==0?
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorGrey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Center(
                                  child: Text('No Club Post'),
                                ),

                              ),
                            ):
                            PostWidget(
                              userId: widget.userModel.sId,
                              post: clubFeeds[0],
                              title: 'Club New Post',
                            ),
                            teamFeeds.length==0?
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorGrey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Center(
                                  child: Text('No Team Post'),
                                ),

                              ),
                            ):
                            PostWidget(
                              userId: widget.userModel.sId,
                              post: teamFeeds[0],
                              title: 'Team New Post',
                            ),
                          ],
                        ),
                      ),
          ),
          Column(
            children: [
              MainWidget(
                text: 'My workout',
                postImage: IMG_FORWARD,
                preImage: IMG_WORKOUT,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkOutView()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              MainWidget(
                text: 'My Coaches',
                postImage: IMG_FORWARD,
                preImage: IMG_WHISTLE,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CoachesView()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              MainWidget(
                text: 'My Clubs',
                postImage: IMG_FORWARD,
                preImage: IMG_CLUB,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClubView()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              MainWidget(
                text: 'My Teams',
                postImage: IMG_FORWARD,
                preImage: IMG_TEAMS,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamView()),
                  );
                },
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            margin: EdgeInsets.only(bottom: 10),
            child: isSponsorLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : sponsors.length == 0
                    ? Center(
                        child: Text('No Sponsors'),
                      )
                    : ListView.builder(
                        itemCount: sponsors.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          SponsorModel sponsor = sponsors[index];
                          return Center(
                            child: Container(
                              width: 150.0,
                              height: 60,
                              child: InkWell(
                                child: CachedImage(
                                  image: ApiClient.baseUrl + sponsor.image,
                                  imageHeight: 80.0,
                                  radius: 15,
                                  imageWidth: 80,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SponsorDetailView(
                                                sponsor: sponsor,
                                              )));
                                },
                              ),
                            ),
                          );
                        }),
          ),
        ],
      ),
    );
  }

  getSponsors(String userId) async {
    setState(() {
      isSponsorLoading = true;
    });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetSponsors;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isSponsorLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      SponsorsResponse mResponse =
          SponsorsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          sponsors = mResponse.sponsers;
          isSponsorLoading = false;
        });
      } else {
        setState(() {
          isSponsorLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isSponsorLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  getHomeFeeds() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlAthleteHome;
    print('User ID: ' + widget.userModel.sId);
    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userModel.sId,
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
      HomePostResponse mResponse =
          HomePostResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          clubFeeds = mResponse.clubPosts;
          teamFeeds = mResponse.teamPosts;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
