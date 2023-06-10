import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/CoachModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralResponse.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AthleteView/Coach/Coaches/CoachesDetails.dart';
import 'package:us_rowing/widgets/AddMenuButton.dart';
import 'package:http/http.dart' as http;

import '../CachedImage.dart';

class CoachesWidget extends StatefulWidget {
  final String name;
  final String image;
  final String userId;
  final String coachId;
  final Function onAdd;
  final CoachModel coachModel;

  CoachesWidget(
      {this.image = '',
      this.name = '',
      required this.userId,
      required this.coachId,
      required this.onAdd,
      required this.coachModel});

  @override
  _CoachesWidgetState createState() => _CoachesWidgetState();
}

class _CoachesWidgetState extends State<CoachesWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
      child: InkWell(
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CachedImage(image: widget.image,radius: 100,),
                  Flexible(child: Text(widget.name,maxLines: 2,overflow: TextOverflow.fade,textAlign: TextAlign.center,)),
                  AddMenuButton(
                      progress: isLoading,
                      text: 'ADD',
                      onPressed: () {
                        assignCoach();
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
                builder: (context) => CoachesDetails(
                      coachesName: widget.name,
                      coachesImage: widget.image,
                  coachModel: widget.coachModel,
                    )),
          );
        },
      ),
    );
  }

  assignCoach() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + widget.userId);
    print('coachId' + widget.coachId);
    String apiUrl =
        ApiClient.urlAssignCoach + widget.userId + '/' + widget.coachId;

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
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    }
  }
}
