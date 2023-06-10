import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ClubTeamsResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:http/http.dart' as http;

class MyClubInfo extends StatefulWidget {
  final String clubImage;
  final ClubModel clubModel;
  final String userId;

  MyClubInfo(
      {this.clubImage = '', required this.clubModel, required this.userId});

  @override
  _MyClubInfoState createState() => _MyClubInfoState();
}

class _MyClubInfoState extends State<MyClubInfo> {
  bool isLoading = true;
  List<TeamModel> teams = [];
  List<String> associations = [];

  @override
  void initState() {
    super.initState();
    associations = widget.clubModel.associations;
    getTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 28.0, bottom: 8.0),
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        elevation: 8.0,
                        borderRadius: BorderRadius.circular(100),
                        child: CachedImage(
                          padding: 0,
                          image: widget.clubImage,
                          placeHolder: IMG_INFO,
                          radius: 100,
                          imageHeight: 60,
                          imageWidth: 60,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          widget.clubModel.clubName,
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
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ABOUT US',
                              style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.clubModel.about,
                              style:
                                  TextStyle(fontSize: 11.0, color: colorBlack),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TEAMS',
                              style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : teams.length == 0
                                    ? Center(
                                        child: Text('No Members'),
                                      )
                                    : GridView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: teams.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 6.0,
                                          mainAxisSpacing: 0.0,
                                          crossAxisSpacing: 10.0,
                                          crossAxisCount: 2,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          TeamModel team = teams[index];
                                          index = index + 1;
                                          return Text(
                                            index.toString() +
                                                '.' +
                                                team.teamName,
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                color: colorBlack),
                                          );
                                        },
                                      ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'CONTACT US',
                              style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Cell No:',
                                  style: TextStyle(
                                      fontSize: 11.0, color: colorBlack),
                                ),
                                SizedBox(width: 30.0),
                                Text(
                                  widget.clubModel.cell,
                                  style: TextStyle(
                                      fontSize: 11.0, color: colorBlack),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.clubModel.city,
                              style:
                                  TextStyle(fontSize: 11.0, color: colorBlack),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.clubModel.location,
                              style:
                                  TextStyle(fontSize: 11.0, color: colorBlack),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                            SizedBox(
                              height: 10.0,
                            ),
                            associations.length == 0
                                ? Center(
                                    child: Text('No Associations'),
                                  )
                                : GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: associations.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 6.0,
                                      mainAxisSpacing: 0.0,
                                      crossAxisSpacing: 10.0,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String association = associations[index];
                                      index = index + 1;
                                      return Text(
                                        index.toString() + '.' + association,
                                        style: TextStyle(
                                            fontSize: 11.0, color: colorBlack),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTeams() async {
    print('clubId' + widget.clubModel.sId);
    String apiUrl = ApiClient.urlAllTeamsOfClubs;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'club_id': widget.clubModel.sId,
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      ClubTeamsResponse mResponse =
          ClubTeamsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          teams = mResponse.assignedTeams;
          teams.addAll(mResponse.allTeams);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
