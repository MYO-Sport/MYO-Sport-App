import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamMemberModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/TeamMembersResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/TeamMemberWidget.dart';

class MyTeamMembers extends StatefulWidget {
  final String teamId;

  MyTeamMembers({required this.teamId});

  @override
  _MyTeamMembersState createState() => _MyTeamMembersState();
}

class _MyTeamMembersState extends State<MyTeamMembers> {
  bool isLoading = true;
  List<TeamMemberModel> members = [];
  List<TeamMemberModel> showMembers = [];

  late String userId;


  @override
  void initState() {
    super.initState();
    print('My Team Member');
    getUser().then((value){
      setState(() {
        userId=value.sId;
      });
      getMembers();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          InputFieldSuffix(
            text: 'Search...',
            suffixImage: 'assets/images/arrow.png',
            onChange: onSearch,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
            child: Text(
              'Team Members',
              style: TextStyle(
                  color: colorBlack,
                  fontSize: 16.0,
                  letterSpacing: 0.5),
            ),
          ),
          Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : showMembers.length == 0
                      ? Center(
                          child: Text('No Members Found'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: showMembers.length,
                          itemBuilder: (BuildContext context, int index) {
                            TeamMemberModel member = showMembers[index];
                            return TeamMemberWidget(image: member.memberImage, email: member.memberEmail, name: member.memberName,id: member.memberId,userId: userId,type: member.memberRole,

                            );
                          },
                        )),
        ],
      ),
    );
  }

  getMembers() async {
    setState(() {
      isLoading = true;
    });

    print('teamId: ' + widget.teamId);

    String apiUrl = ApiClient.urlGetTeamMembers + widget.teamId;

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
          showMembers.clear();
          members = mResponse.team;
          showMembers.addAll(members);
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

  onSearch(String text){
    print(text);
    if(text.isNotEmpty){
      showMembers.clear();
      for(TeamMemberModel club in members){
        if(club.memberName.toLowerCase().contains(text.toLowerCase())){
          showMembers.add(club);
        }
      }
      setState(() {});
    }else{
      showMembers.clear();

      setState(() {
        showMembers.addAll(members);
      });
    }
  }

}
