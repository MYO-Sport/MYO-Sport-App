import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/EventModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/CoachEventResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/Coach%20User/MyEventWidget.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class EventViewDetails extends StatefulWidget {

  final String userId;

  EventViewDetails({required this.userId});

  @override
  _EventViewDetailsState createState() => _EventViewDetailsState();
}

class _EventViewDetailsState extends State<EventViewDetails> {

  bool isLoading=true;
  List<EventModel> events=[];

  void initState() {
    super.initState();
    getEvents();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      appBar: SimpleToolbar(title: 'My Events',isBack: false,),
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
            EventModel event=events[index];
            return MyEventWidget(
              status: 0,
              userId: widget.userId,
              userType: typeCoach,
              event: event,
            );
          }),
    );
  }

  getEvents() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetMyEvents;

    print('userId: '+widget.userId);

    final response = await http.post(Uri.parse(apiUrl),
        body: {'coach_id': widget.userId}).catchError((value) {
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
      CoachEventResponse mResponse =
      CoachEventResponse.fromJson(json.decode(responseString));
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
