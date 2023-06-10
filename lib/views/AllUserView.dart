import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/UsersResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:us_rowing/widgets/UserWidget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AllUserView extends StatefulWidget {

  final IO.Socket socket;
  final String userId;
  final bool share;
  final String workoutId;
  final String workoutName;
  final String workoutImage;

  AllUserView({required this.socket, required this.userId,required this.share,required this.workoutId,required this.workoutName,required this.workoutImage});
  @override
  _AllUserViewState createState() => _AllUserViewState();
}

class _AllUserViewState extends State<AllUserView> {
  bool isLoading = true;
  late List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleToolbar(title: 'Users'),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),


                  isLoading
                      ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(child: CircularProgressIndicator()))
                      : users.length == 0
                      ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(
                          child: Text(
                            'No Users Found',
                            style: TextStyle(color: colorGrey),
                          )))
                      : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      UserModel user = users[index];
                      return UserWidget(
                        image: ApiClient.baseUrl + user.profileImage,
                        name: user.username,
                        id: user.sId,
                        socket: widget.socket,
                        currentId: widget.userId,
                        share: widget.share, workoutName: widget.workoutName, workoutId: widget.workoutId,
                        workoutImage: widget.workoutImage,
                        userType: user.type,
                      );
                    },
                  ),

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
    getUsers();
  }

  getUsers() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetAllUsers;

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
      UsersResponse mResponse =
      UsersResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          users = mResponse.users;
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
}
