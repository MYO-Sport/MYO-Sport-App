import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/NotificationModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/NotificationsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/NotificationWidget.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() =>
      _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  List<NotificationModel> notifications = [];
  bool isLoading = false;

  String userId='';

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
        userId=value.sId;
      });
      getNotifications(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: SimpleToolbar(title: 'Notifications'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : notifications.length == 0
              ? Center(
                  child: Text('No Notifications'),
                )
              : SafeArea(
                child: ListView.builder(
                  itemCount: notifications.length,

          itemBuilder: (context,index){
                    NotificationModel notification=notifications[index];
                  return NotificationWidget(
                    userId: userId,
                    notification:  notification,

                  );
      }),
              ),
    );
  }

  getNotifications(String userId) async {
    setState(() {
      isLoading = true;
    });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetNotifications + userId;

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
      NotificationsResponse mResponse =
      NotificationsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          notifications=mResponse.notifications;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading= false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
