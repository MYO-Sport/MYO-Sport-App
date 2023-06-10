import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/EventDataModel.dart';
import 'package:us_rowing/models/EventModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/EventsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CoachView/EventViewCoach/AddEventView.dart';
import 'package:us_rowing/widgets/Coach%20User/MyEventWidget.dart';
import 'package:http/http.dart' as http;

class UsFeedEvent extends StatefulWidget {
  final bool isAdmin;

  UsFeedEvent({required this.isAdmin});

  @override
  _UsFeedEventState createState() => _UsFeedEventState();
}

class _UsFeedEventState extends State<UsFeedEvent> {
  bool isLoading = true;
  List<EventDataModel> events = [];

  late String userId;
  late String userType;
  bool addAble = false;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userType = value.type;
        userId = value.sId;
        print('Type: ' + userType);
        if (widget.isAdmin) {
          addAble = true;
        }
      });
      getEvents(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
        body: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20, top: 20.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextStyle(color: colorBlack, fontSize: 18),
                  ),
                  addAble?
                  InkWell(
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                        color: colorBackButton.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: colorBackButton,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Add Event',
                            style:
                                TextStyle(color: colorBackButton, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEventView(
                                creatorId: '',
                                userId: userId,
                                type: typeUsFeed,
                              ))).then((value) {
                        setState(() {
                          isLoading = true;
                        });
                        getEvents(userId);
                      });
                    },
                  ):SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : events.length == 0
                      ? Center(
                          child: Text('No Events'),
                        )
                      : ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            EventModel event = events[index].event;
                            int status = events[index].status;
                            return MyEventWidget(
                              status: status,
                              userId: userId,
                              userType: userType,
                              event: event,
                            );
                          }),
            )
          ],
        ));
  }

  getEvents(String userId) async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetUSEvents;

    print('userId: ' + userId);

    final response = await http
        .post(Uri.parse(apiUrl), body: {'user_id': userId}).catchError((value) {
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
          events = mResponse.events;
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
