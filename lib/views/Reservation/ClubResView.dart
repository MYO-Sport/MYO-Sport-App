import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ClubsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/Club/ClubWidget.dart';
import 'package:us_rowing/widgets/ClubResWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class ClubResView extends StatefulWidget {

  final bool isBack;
  final bool allClubs;

  ClubResView({this.isBack=true,this.allClubs=true});
  @override
  _ClubResViewState createState() => _ClubResViewState();
}

class _ClubResViewState extends State<ClubResView> {
  bool isLoading = true;
  List<ClubModel> assignedClubs = [];
  List<ClubModel> clubs = [];
  List<ClubModel> showAssignedClubs = [];
  List<ClubModel> showClubs = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getClubs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      resizeToAvoidBottomInset: false,
      appBar: SimpleToolbar(title: 'Select Club'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            InputFieldSuffix(
              text: 'Search club',
              suffixImage: 'assets/images/search.png',
              onChange: onSearch,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
              child: Text(
                'MY CLUBS',
                style: TextStyle(
                    color: colorBlack,
                    fontSize: 16.0,
                    letterSpacing: 0.5),
              ),
            ),

            isLoading
                ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Center(child: CircularProgressIndicator()))
                : showAssignedClubs.length == 0
                ? Container(
                width: MediaQuery.of(context).size.width,
                height:
                MediaQuery.of(context).size.height * 0.15,
                child: Center(
                    child: Text(
                      'No Subscribed Clubs',
                      style: TextStyle(color: colorGrey),
                    )))
                : ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: showAssignedClubs.length,
              itemBuilder: (context, index) {
                ClubModel club = showAssignedClubs[index];
                return ClubResWidget(
                  userId: userId,
                  clubId: club.sId,
                  image:
                  ApiClient.mediaImgUrl+club.picture.fileName,
                  clubName: club.clubName,
                  clubModel: club,
                );
              },
            ),
            widget.allClubs?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
                  child: Text(
                    'CLUBS',
                    style: TextStyle(
                        color: colorBlack,
                        fontSize: 16.0,
                        letterSpacing: 0.5),
                  ),
                ),
                isLoading
                    ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Center(child: CircularProgressIndicator()))
                    : showClubs.length == 0
                    ? Container(
                    width: MediaQuery.of(context).size.width,
                    height:
                    MediaQuery.of(context).size.height * 0.15,
                    child: Center(
                        child: Text(
                          'No Clubs',
                          style: TextStyle(color: colorGrey),
                        )))
                    : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: showClubs.length,
                    itemBuilder: (context, index) {
                      ClubModel club = showClubs[index];
                      return ClubWidget(
                        clubId: club.sId,
                        userId: userId,
                        name: club.clubName,
                        image:
                        ApiClient.mediaImgUrl+club.picture.fileName,
                        clubModel: club,
                        onAdd: onAdd,
                      );
                    })
              ],
            ):
            SizedBox()
          ],
        ),
      ),
    );
  }

  onAdd(){
    setState(() {
      isLoading=true;
    });
    getClubs();
  }

  getClubs() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetClubs + userId;

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
      ClubsResponse mResponse =
      ClubsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          showClubs.clear();
          showAssignedClubs.clear();
          assignedClubs=mResponse.assignedClubs;
          clubs=mResponse.allClubs;
          showAssignedClubs.addAll(mResponse.assignedClubs);
          showClubs.addAll(mResponse.allClubs);
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
      showAssignedClubs.clear();
      showClubs.clear();
      for(ClubModel club in assignedClubs){
        if(club.clubName.toLowerCase().contains(text.toLowerCase())){
          showAssignedClubs.add(club);
        }
      }
      for(ClubModel club in clubs){
        if(club.clubName.toLowerCase().contains(text.toLowerCase())){
          showClubs.add(club);
        }
      }
      setState(() {});
    }else{
      showAssignedClubs.clear();
      showClubs.clear();

      setState(() {
        showAssignedClubs.addAll(assignedClubs);
        showClubs.addAll(clubs);
      });
    }
  }
}
