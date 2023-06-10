import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/TeamsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:us_rowing/widgets/Team/MyTeamWidget.dart';
import 'package:us_rowing/widgets/Team/TeamWidget.dart';
import 'package:http/http.dart' as http;

class TeamView extends StatefulWidget {
  const TeamView({Key? key}) : super(key: key);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  bool isLoading = true;
  late List<TeamModel> assignedTeams = [];
  late List<TeamModel> teams = [];
  List<TeamModel> showAssignedTeams = [];
  List<TeamModel> showTeams = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getTeams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: colorWhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'TEAMS',
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  width: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    InputFieldSuffix(
                      text: 'Search here . . .',
                      suffixImage: 'assets/images/filter-icon-for-bar.png',
                      onChange: onSearch,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'MY TEAMS',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5),
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
                                    userId: userId,
                                    teamId: team.sId,
                                    image: ApiClient.mediaImgUrl +
                                        team.picture.fileName,
                                    name: team.teamName,
                                    teamModel: team,

                                  );
                                },
                              ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'TEAMS',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    isLoading
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Center(child: CircularProgressIndicator()))
                        : showTeams.length == 0
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
                                    userId: userId,
                                    name: team.teamName,
                                    image: ApiClient.mediaImgUrl +
                                        team.picture.fileName,
                                    onAdd: onAdd,
                                    teamModel: team,
                                  );
                                }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetTeams + userId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      TeamsResponse mResponse =
          TeamsResponse.fromJson(json.decode(responseString));
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
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
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
