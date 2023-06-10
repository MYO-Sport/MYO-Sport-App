import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/RecentWorkoutModel.dart';
import 'package:us_rowing/models/StatModel.dart';
import 'package:us_rowing/models/WorkoutDataModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/WorkoutDataResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AddWorkoutView.dart';
import 'package:us_rowing/widgets/HistoryWidget.dart';
import 'package:us_rowing/widgets/WorkOutWidget.dart';
import 'package:http/http.dart' as http;

class WorkOutView extends StatefulWidget {
  final bool isBack;

  WorkOutView({this.isBack = true});

  @override
  _WorkOutViewState createState() => _WorkOutViewState();
}

class _WorkOutViewState extends State<WorkOutView> {
  bool isLoading = true;
  late WorkoutDataModel workoutData;
  List<RecentWorkoutModel> recentWorkouts = [];

  late DateTime now;
  late String userId;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    workoutData = WorkoutDataModel(
        activeTime: StatModel(total: "0", average: "0"),
        heartRate: StatModel(total: "0", average: "0"),
        steps: StatModel(total: "0", average: "0"),
        distance: StatModel(total: "0", average: "0"),
        calories: StatModel(total: "0", average: "0"),
        totalAscent: StatModel(total: "0", average: "0"));
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getWorkout(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: colorPrimary,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isBack
                      ? InkWell(
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: colorWhite,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      : SizedBox(
                          width: 24,
                        ),
                  Text(
                    'WORKOUTS',
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorBlue),
                )),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: GridView(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1),
                          children: [
                            WorkOutWidget(
                              image: 'assets/images/workouts/distance.png',
                              countDown: workoutData.steps.average,
                              workout: 'Steps',
                            ),
                            WorkOutWidget(
                              image: 'assets/images/workouts/calories.png',
                              countDown: workoutData.calories.average,
                              workout: 'Calories',
                            ),
                            WorkOutWidget(
                              image: 'assets/images/workouts/heart-rate.png',
                              countDown: workoutData.heartRate.average,
                              workout: 'Heart Rate',
                            ),
                            WorkOutWidget(
                              image: 'assets/images/workouts/weight.png',
                              countDown: '0',
                              workout: 'Weight',
                            ),
                            WorkOutWidget(
                              image: 'assets/images/workouts/time.png',
                              countDown: workoutData.activeTime.average,
                              workout: 'Active Time',
                            ),
                            WorkOutWidget(
                              image: 'assets/images/workouts/power.png',
                              countDown: '0',
                              workout: 'Power',
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Material(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2.0,
                        child: Container(
                          height: 50.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Add new workouts',
                                  style: TextStyle(color: colorGrey),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 40.0,
                                    color: colorBlack,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddWorkoutView()),
                                    ).then((value) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      getWorkout(userId);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            recentWorkouts.length == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22.0),
                                    child: Text('No Recent Workouts'),
                                  )
                                : ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: recentWorkouts.length > 5
                                        ? 5
                                        : recentWorkouts.length,
                                    itemBuilder: (context, index) {
                                      RecentWorkoutModel recentWorkout =
                                          recentWorkouts[index];
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
              ));
  }

  getWorkout(String userId) async {
    print('User Id $userId');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetWorkoutHistory + userId;

    final response = await http.post(Uri.parse(apiUrl)).catchError((value) {
      setState(() {
        isLoading = false;
      });

      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      WorkoutDataResponse mResponse =
          WorkoutDataResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          recentWorkouts = mResponse.recentWorkouts;
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
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error' + 'Check Your Internet Connection');
    }
  }
}
