import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ClubTeamsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/Team/MyTeamWidget.dart';

class MyClubTeam extends StatefulWidget {
  final String clubName;
  final String clubImage;
  final String clubId;
  final String userId;

  MyClubTeam({this.clubName = '', this.clubImage = '', required this.clubId,required this.userId});

  @override
  _MyClubTeamState createState() => _MyClubTeamState();
}

class _MyClubTeamState extends State<MyClubTeam> {

  bool isLoading = true;
  late List<TeamModel> assignedTeams = [];
  late List<TeamModel> teams = [];
  List<TeamModel> showAssignedTeams = [];
  List<TeamModel> showTeams = [];

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      InputFieldSuffix(
                        text: 'Search here . . .',
                        suffixImage: 'assets/images/search.png',
                        onChange: onSearch,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
                        child: Text(
                          'MY TEAMS',
                          style: TextStyle(
                              color: colorBlack,
                              fontSize: 16.0,
                              letterSpacing: 0.5),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      isLoading
                          ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Center(child: CircularProgressIndicator()))
                          : showAssignedTeams.length == 0
                          ? Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height * 0.15,
                          child: Center(
                              child: Text(
                                'No Assigned Teams',
                                style: TextStyle(color: colorGrey),
                              )))
                          : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: showAssignedTeams.length,
                        itemBuilder: (context, index) {
                          TeamModel team = showAssignedTeams[index];
                          return MyTeamWidget(
                            userId: widget.userId,
                            teamId: team.sId,
                            image: ApiClient.mediaImgUrl +
                                team.picture.fileName,
                            name: team.teamName,
                            teamModel: team,

                          );
                        },
                      ),
                      /*SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
                        child: Text(
                          'TEAMS',
                          style: TextStyle(
                              color: colorBlack,
                              fontSize: 16.0,
                              letterSpacing: 0.5),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      isLoading
                          ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Center(child: CircularProgressIndicator()))
                          : showTeams == null || showTeams.length == 0
                          ? Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height * 0.15,
                          child: Center(
                              child: Text(
                                'No Teams',
                                style: TextStyle(color: colorGrey),
                              )))
                          : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: showTeams.length,
                          itemBuilder: (context, index) {
                            TeamModel team = showTeams[index];
                            return TeamWidget(
                              teamId: team.sId,
                              userId: widget.userId,
                              name: team.teamName,
                              image: ApiClient.mediaImgUrl +
                                  team.picture.fileName,
                              onAdd: onAdd,
                              teamModel: team,
                            );
                          }),*/
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  onAdd() {
    setState(() {
      isLoading = true;
    });
    getTeams();
  }

  getTeams() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + widget.userId);
    print('clubId' + widget.clubId);
    String apiUrl = ApiClient.urlAllTeamsOfClubs;

    final response = await http
        .post(
      Uri.parse(apiUrl),
      body: {
        'user_id':widget.userId,
        'club_id' :widget.clubId,
      }
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
      ClubTeamsResponse mResponse =
      ClubTeamsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          showTeams.clear();
          showAssignedTeams.clear();
          assignedTeams = mResponse.assignedTeams;
          teams = mResponse.allTeams;
          showAssignedTeams.addAll(mResponse.assignedTeams);
          showTeams.addAll(mResponse.allTeams);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  onSearch(String text){
    if(text.isNotEmpty){
      showAssignedTeams.clear();
      showTeams.clear();
      for(TeamModel club in assignedTeams){
        if(club.teamName.toLowerCase().contains(text.toLowerCase())){
          showAssignedTeams.add(club);
        }
      }
      for(TeamModel club in teams){
        if(club.teamName.toLowerCase().contains(text.toLowerCase())){
          showTeams.add(club);
        }
      }
      setState(() {});
    }else{
      showAssignedTeams.clear();
      showTeams.clear();

      setState(() {
        showAssignedTeams.addAll(assignedTeams);
        showTeams.addAll(teams);
      });
    }
  }
}
