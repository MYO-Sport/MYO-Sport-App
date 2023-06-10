import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/CreatorModel.dart';
import 'package:us_rowing/models/EventDataModel.dart';
import 'package:us_rowing/models/EventModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/EventsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/Coach%20User/MyEventWidget.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class MyEventView extends StatefulWidget {

  final bool isBack;

  MyEventView({this.isBack=true});
  @override
  _MyEventViewState createState() => _MyEventViewState();
}

class _MyEventViewState extends State<MyEventView> {

  bool isLoading=true;
  List<EventDataModel> events=[];

  late String userId;
  late CreatorModel creator;

  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
        creator=CreatorModel(sId: value.sId, username: value.username, email: value.email, profileImage: value.profileImage,type: value.type);
        userId=value.sId;
      });
      getEvents();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightGrey,
      appBar: SimpleToolbar(title: 'My Events', isBack: widget.isBack,),
      body:
      isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : events.length == 0
          ? Center(
        child: Text('No Events'),
      ):
      ListView.builder(
          itemCount: events.length,
          itemBuilder: (context,index){
            EventModel event=events[index].event;
            event.createrInfo=[];
            event.createrInfo.add(creator);
            return MyEventWidget(
              status: events[index].status,
              userId: userId,
              userType: typeAthlete,
              event: event,
            );
          }),
    );
  }

  getEvents() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlAthleteEvents;

    print('userId: '+userId);

    final response = await http.post(Uri.parse(apiUrl),
        body: {'user_id': userId}).catchError((value) {
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
      EventsResponse mResponse =
      EventsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          events=mResponse.events;
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
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
