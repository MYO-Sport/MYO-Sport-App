import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/CoachModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/CoachesResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/Coach/CoachesWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:us_rowing/widgets/Coach/MyCoachesWidget.dart';
import 'package:http/http.dart' as http;

class CoachesView extends StatefulWidget {
  final bool isBack;

  CoachesView({this.isBack = true});
  @override
  _CoachesViewState createState() => _CoachesViewState();
}

class _CoachesViewState extends State<CoachesView> {
  bool isLoading = true;
  late List<CoachModel> showAssignedCoaches = [];
  late List<CoachModel> showCoaches = [];
  late List<CoachModel> assignedCoaches = [];
  late List<CoachModel> coaches = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getCoaches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                widget.isBack ? InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: colorWhite,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ) : SizedBox(width: 24,),
                  Text(
                    'COACHES',
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
                    height: 8.0,
                  ),
                  Text(
                    'MY COACHES',
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
                      :  showAssignedCoaches.length == 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Center(
                                  child: Text(
                                'No Subscribed Coaches',
                                style: TextStyle(color: colorGrey),
                              )))
                          : ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: showAssignedCoaches.length,
                              itemBuilder: (context, index) {
                                CoachModel coach = showAssignedCoaches[index];
                                return MyCoachesWidget(
                                  image: ApiClient.baseUrl+coach.profileImage,
                                  name: coach.username,
                                  coachId: coach.sId,
                                  coachModel: coach,
                                  roomId: '',
                                );
                              },
                            ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'COACHES',
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
                      :  showCoaches.length == 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Center(
                                  child: Text(
                                'No Coaches',
                                style: TextStyle(color: colorGrey),
                              )))
                          : ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: showCoaches.length,
                              itemBuilder: (context, index) {
                                CoachModel coach = showCoaches[index];
                                return CoachesWidget(
                                  coachId: coach.sId,
                                  userId: userId,
                                  name: coach.username,
                                  image: ApiClient.baseUrl+coach.profileImage,
                                  onAdd: onAdd,
                                  coachModel: coach,
                                );
                              })
                ],
              ),
            ],
          ),
        ));
  }

  onAdd() {
    setState(() {
      isLoading = true;
    });
    getCoaches();
  }

  getCoaches() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetCoaches + userId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + value.toString());
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      CoachesResponse mResponse =
          CoachesResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          showAssignedCoaches.clear();
          showCoaches.clear();
          assignedCoaches = mResponse.assignedCoaches;
          coaches = mResponse.allCoaches;
          showAssignedCoaches.addAll(assignedCoaches);
          showCoaches.addAll(coaches);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(context, 'Error: ' + 'Something Went Wrong');
    }
  }

  onSearch(String text){
    if(text.isNotEmpty){
      showAssignedCoaches.clear();
      showCoaches.clear();
      for(CoachModel coach in assignedCoaches){
        if(coach.username.toLowerCase().contains(text.toLowerCase())){
          showAssignedCoaches.add(coach);
        }
      }
      for(CoachModel coach in coaches){
        if(coach.username.toLowerCase().contains(text.toLowerCase())){
          showCoaches.add(coach);
        }
      }
      setState(() {});
    }else{
      showAssignedCoaches.clear();
      showCoaches.clear();

      setState(() {
        showAssignedCoaches.addAll(assignedCoaches);
        showCoaches.addAll(coaches);
      });
    }
  }
}
