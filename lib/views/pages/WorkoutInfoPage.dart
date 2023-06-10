import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/RecentWorkoutModel.dart';
import 'package:us_rowing/models/WorkoutDataModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/WorkoutDataResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/HistoryWidget.dart';
import 'package:http/http.dart' as http;

class WorkoutInfoPage extends StatefulWidget {

  final String athleteId;

  WorkoutInfoPage({required this.athleteId});

  @override
  _WorkoutInfoPageState createState() => _WorkoutInfoPageState();
}

class _WorkoutInfoPageState extends State<WorkoutInfoPage> {

  late WorkoutDataModel workoutData;
  List<RecentWorkoutModel> recentWorkouts=[];

  bool isLoading=true;
  List<String> workouts=[];

  late DateTime now;

  @override
  void initState() {
    super.initState();
    now= DateTime.now();
    getWorkout(widget.athleteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      isLoading
          ? Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorBlue),
            )),
      ):
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Card(
                borderOnForeground: true,
                elevation: 5.0,
                color: colorWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    Material(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2.0,
                      child: Container(
                        height: 50.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Workout History',
                                style: TextStyle(color: colorGrey),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 55.0,
                                color: colorBlack.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    recentWorkouts.length==0?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      child: Text('No Workouts Found',style: TextStyle(color: colorGrey,fontSize: 12),),
                    ):
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: recentWorkouts.length,
                        itemBuilder: (context,index){
                          RecentWorkoutModel recentWorkout=recentWorkouts[index];
                          return HistoryWidget(
                            workoutId: recentWorkout.sId,
                            now: now,
                            workOut: recentWorkout.workoutName,
                            days: recentWorkout.createdAt,
                            imgUrl: recentWorkout.workoutImage,
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getWorkout(String userId) async {

    print('AthleteId: $userId');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetWorkoutHistory+userId;

    final response = await http
        .post(Uri.parse(apiUrl))
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      WorkoutDataResponse mResponse =
      WorkoutDataResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          recentWorkouts=mResponse.recentWorkouts;
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading=false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error' + 'Check Your Internet Connection');
    }
  }

}
