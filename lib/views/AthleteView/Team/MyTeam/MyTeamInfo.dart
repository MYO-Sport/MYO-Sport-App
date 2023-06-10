import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamMemberModel.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/TeamMembersResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:http/http.dart' as http;

class MyTeamInfo extends StatefulWidget {
  final String teamImage;
  final TeamModel teamModel;

  MyTeamInfo({this.teamImage = '',required this.teamModel});

  @override
  _MyTeamInfoState createState() => _MyTeamInfoState();
}

class _MyTeamInfoState extends State<MyTeamInfo> {
  bool isLoading = false;
  List<TeamMemberModel> members = [];
  List<String> associations = [];

  @override
  void initState() {
    super.initState();
    associations = widget.teamModel.associations;
    getMembers();
    // members = widget.coachModel.members;
    // associations = widget.coachModel.associations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.only(left: 15.0,right: 15.0, top: 28.0, bottom: 8.0),
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              children: <Widget>[

                SizedBox(height: 20,),
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
                          image: widget.teamImage,
                          placeHolder: IMG_PLACEHOLDER,
                          radius: 100,
                          imageHeight: 60,
                          imageWidth: 60,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        child: Text(
                          widget.teamModel.teamName,
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ABOUT',
                              style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.teamModel.about,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  color: colorBlack),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TEAM MEMBERS',
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(height:20,width: 20,child: CircularProgressIndicator(strokeWidth: 2,)),
                              ),
                            )
                                : members.length == 0
                                ? Center(
                              child: Text('No Team Members',style: TextStyle(fontSize: 12.0,color: colorGrey)),
                            ):
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: members.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 6.0,
                                mainAxisSpacing: 0.0,
                                crossAxisSpacing: 10.0,
                                crossAxisCount: 2,
                              ),
                              itemBuilder:
                                  (BuildContext context, int index) {
                                TeamMemberModel member = members[index];
                                index = index + 1;
                                return Text(
                                  index.toString() + '.' + member.memberName,
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
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
                              child: Text('No ASSOCIATIONS',style: TextStyle(fontSize: 12.0,color: colorGrey)),
                            ):
                            GridView.builder(
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'CONTACT ME',
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
                                  'CONTACT NO:',
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      color: colorBlack),
                                ),
                                SizedBox(width: 10.0,),
                                Text(
                                  widget.teamModel.cell,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      color: colorBlack),
                                ),
                                SizedBox(width: 30.0),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      color: colorBlack),
                                ),
                                SizedBox(width: 10.0,),
                                Text(
                                  widget.teamModel.email,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      color: colorBlack),
                                ),
                                SizedBox(width: 30.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ADDRESS',
                              style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.teamModel.address,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  color: colorBlack),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  getMembers() async {
    setState(() {
      isLoading = true;
    });

    print('teamId: ' + widget.teamModel.sId);

    String apiUrl = ApiClient.urlGetTeamMembers + widget.teamModel.sId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      TeamMembersResponse mResponse =
      TeamMembersResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          members = mResponse.team;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: Something Went Wrong');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
