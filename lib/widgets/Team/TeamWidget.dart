import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AthleteView/Team/Teams/TeamDetails.dart';
import 'package:us_rowing/widgets/AddMenuButton.dart';
import 'package:http/http.dart' as http;

import '../CachedImage.dart';

class TeamWidget extends StatefulWidget {
  final String name;
  final String image;
  final String teamId;
  final String userId;
  final Function onAdd;
  final TeamModel teamModel;

  TeamWidget(
      {this.image = '',
      this.name = '',
      required this.teamId,
      required this.userId,
      required this.onAdd,
      required this.teamModel});

  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
      child: InkWell(
        child: Material(
          color: colorWhite,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: colorLightGrey,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: CachedImage(
                        image: widget.image,
                        radius: 0,
                        fit: BoxFit.fill,
                        padding: 0,
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.name,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                    ),
                  )),
                  AddMenuButton(
                      progress: isLoading,
                      text: 'ADD',
                      onPressed: () {
                        assignTeam();
                      })
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeamDetails(
                      teamModel: widget.teamModel,
                      teamImage: widget.image,
                      teamName: widget.teamModel.teamName,
                    )),
          );
        },
      ),
    );
  }

  assignTeam() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + widget.userId);
    print('clubId' + widget.teamId);
    String apiUrl =
        ApiClient.urlAssignTeams + widget.userId + '/' + widget.teamId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralResponse mResponse =
          GeneralResponse.fromJson(json.decode(responseString));
      if (mResponse.success) {
        widget.onAdd();
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
