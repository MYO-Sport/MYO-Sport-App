import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/body/GroupBody.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/network/response/UsersResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/GridItem.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CreateGroup extends StatefulWidget {

  final IO.Socket socket;
  final String userId;
  final String groupName;

  CreateGroup({required this.socket, required this.userId, required this.groupName});
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  bool isLoading = true;
  late List<UserModel> users = [];
  List<String> selectedUsers=[];

  bool creatingGroup=false;

  late GroupBody body;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleToolbar(title: widget.groupName),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),


                    isLoading
                        ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.15,
                        child: Center(child: CircularProgressIndicator()))
                        : users.length == 0
                        ? Container(
                        width: MediaQuery.of(context).size.width*0.15,
                        height: MediaQuery.of(context).size.height,
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
                        return GridItem(
                            item: users[index],
                            isSelected: (bool value) {
                              setState(() {
                                if (value) {
                                  selectedUsers.add(user.sId);
                                } else {
                                  selectedUsers.remove(user.sId);
                                }
                              });
                              print("$index : $value");
                            },
                            key: Key(user.sId.toString()));
                      },
                    ),

                  ],
                ),
              ),
              isLoading || users.length==0?
              SizedBox():
              Positioned(
                left: 0,
                  right: 0,
                  bottom: 20,
                  child: PrimaryButton(text: 'Create Group',onPressed: (){
                if(validate()){
                  createGroup();
                }
              },)),
              creatingGroup
                  ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator())):SizedBox()
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

  bool validate(){
    if(selectedUsers.length==0){
      MySnackBar.showSnackBar(context, 'Select at least one Group member');
      return false;
    }
    body=GroupBody(name: widget.groupName, createrId: widget.userId, members: selectedUsers);
    return true;
  }

  createGroup() async {
    setState(() {
      creatingGroup = true;
    });
    String apiUrl = ApiClient.urlCreateGroup;

    final response = await http
        .post(
      Uri.parse(apiUrl), headers: {'Content-Type': 'application/json'},
        body: json.encode(body)
    )
        .catchError((value) {
      setState(() {
        creatingGroup = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        showToast(mResponse.message);
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          creatingGroup = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        creatingGroup = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
