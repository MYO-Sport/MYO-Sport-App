import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/WorkoutsModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/WorkOutResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AddWorkoutWidget.dart';

class AddWorkout extends StatefulWidget {
  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  late List<WorkoutsModel> workOuts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getWorkOuts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      body: isLoading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
              )))
          : workOuts.length == 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: Text(
                    'No WorkOuts',
                    style: TextStyle(color: colorGrey),
                  )))
              : ListView.builder(
                  itemCount: workOuts.length,
                  itemBuilder: (context, index) {
                    WorkoutsModel workOut = workOuts[index];
                    return AddWorkoutWidget(
                      workoutId: workOut.sId,
                      workoutName: workOut.workoutName,
                      image: workOut.workoutImage,
                      activities: workOut.activities,
                    );
                  },
                ),
    );
  }

  getWorkOuts() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetAllWorkOuts;

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

      WorkOutResponse mResponse =
          WorkOutResponse.fromJson(json.decode(responseString));
      print(mResponse);
      if (mResponse.status) {
        setState(() {
          workOuts = mResponse.workouts;
          isLoading = false;
        });
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
