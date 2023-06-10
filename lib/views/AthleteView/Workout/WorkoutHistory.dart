import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/RecentWorkoutModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/network/response/WorkoutDataResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AthleteView/Workout/C2WebView.dart';
import 'package:us_rowing/views/StravaWebView.dart';
import 'package:us_rowing/widgets/EventInputField.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/WorkoutHistoryWidget.dart';

class WorkoutHistory extends StatefulWidget {
  final bool isBack;

  WorkoutHistory({this.isBack = true});

  @override
  _WorkoutHistoryState createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  bool isLoading = true;
  bool savingEmail = false;
  List<RecentWorkoutModel> recentWorkouts = [];

  late DateTime now;
  late DateTime selectedStartDate, selectedEndDate, selectedDate;
  late String userId;

  DateTimeRange? picked;

  late Dialog groupDialog;
  TextEditingController emailController = TextEditingController();

  String strDate = '';
  var formatter = new DateFormat('dd MMM');

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    selectedStartDate = now.subtract(Duration(days: 15));
    selectedEndDate = now;
    selectedDate = now;
    strDate = formatter.format(selectedStartDate) +
        '-' +
        formatter.format(selectedEndDate);
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getWorkout(value.sId);
    });

    groupDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Concept2',
                style: TextStyle(color: colorPrimary, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventInputField(
                    controller: emailController,
                    text: 'Enter Concept2 Email',
                    borderColor: colorGrey,
                    maxLength: 50,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Enter Your Concept2 Email here',
                      style: TextStyle(color: colorGrey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            PrimaryButton(
              text: 'Save'
                  '',
              startColor: colorPrimary,
              endColor: colorPrimary,
              radius: 10,
              onPressed: () {
                if (!validEmail(emailController.text)) {
                  showToast('Valid email is required');
                } else {
                  Navigator.of(context).pop();
                  saveEmail(userId);
                }
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackgroundLight,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20, bottom: 10, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sort workouts by date',
                        style: TextStyle(color: colorBlack, fontSize: 14),
                      ),
                      InkWell(
                        child: Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            color: colorBackButton.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                strDate,
                                style: TextStyle(
                                    color: colorBackButton, fontSize: 10),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: colorBackButton,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          picked = await showDateRangePicker(
                            context: context,
                            firstDate: new DateTime(DateTime.now().year - 10),
                            lastDate: now,
                          );
                          if (picked != null) {
                            setState(
                              () {
                                selectedStartDate = picked!.start;
                                selectedEndDate = picked!.end;
                                strDate = formatter.format(selectedStartDate) +
                                    '-' +
                                    formatter.format(selectedEndDate);
                                isLoading = true;
                              },
                            );
                            getWorkout(userId);
                          }
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 20, left: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                  child: Text(
                                'Sync with Concept2',
                                style:
                                    TextStyle(color: colorBlack, fontSize: 14),
                                maxLines: 1,
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 16,
                                width: 16,
                              ),
                            ],
                          ),
                          onTap: () {
                            if (!isLoading) {
                              checkEmail(userId);
                            }

                            /*Navigator.push(context, MaterialPageRoute(builder: (context) => StravaWebView(userId: userId,))).then((value){
                              if(value is bool && value){
                                setState(() {
                                  isLoading=true;
                                });
                                getWorkout(userId);
                              }
                            });*/
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                  child: Text(
                                'Sync with Strava',
                                style:
                                    TextStyle(color: colorBlack, fontSize: 14),
                                maxLines: 1,
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                imgStrava,
                                height: 16,
                                width: 16,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StravaWebView(
                                          userId: userId,
                                        ))).then((value) {
                              if (value is bool && value) {
                                setState(() {
                                  isLoading = true;
                                });
                                getWorkout(userId);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(colorPrimary),
                        ))
                      : recentWorkouts.length == 0
                          ? Center(
                              child: Text(
                                'No Data found',
                                style: TextStyle(color: colorGrey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: recentWorkouts.length > 5
                                  ? 5
                                  : recentWorkouts.length,
                              itemBuilder: (context, index) {
                                RecentWorkoutModel recentWorkout =
                                    recentWorkouts[index];
                                return WorkoutHistoryWidget(
                                  workout: recentWorkout,
                                  days: recentWorkout.createdAt,
                                  now: now,
                                  startDate: selectedStartDate,
                                  endDate: selectedEndDate,
                                  userId: userId,
                                );
                                /*return HistoryWidget(
                      workoutId: recentWorkout.sId,
                      now: now,
                      workOut: recentWorkout.workoutName,
                      days: recentWorkout.createdAt,
                      imgUrl: recentWorkout.workoutImage,
                    );*/
                              }),
                ),
              ],
            ),
            savingEmail
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
                  ))
                : SizedBox()
          ],
        ));
  }

  getWorkout(String userId) async {
    recentWorkouts.clear();
    String apiUrl = ApiClient.urlGetWorkoutHistory;

    String mDate =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    String strStartDate =
        '${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}';
    String strEndDate =
        '${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}';

    print('url $apiUrl');
    print('User Id $userId');
    print('Date $mDate');
    print('startDate: $strStartDate');
    print('EndDate $strEndDate');

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': userId,
      'start_date': strStartDate,
      'end_date': strEndDate,
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      print('$value');
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

  saveEmail(String userId) async {
    setState(() {
      savingEmail = true;
    });
    String apiUrl = ApiClient.urlSaveC2Email;
    String email = emailController.text;

    print('url $apiUrl');
    print('User Id $userId');
    print('email: $email');

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': userId,
      'concept2_email': email,
    }).catchError((value) {
      setState(() {
        savingEmail = false;
      });
      print('$value');
      showToast('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          print("Saved");
          savingEmail = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => C2WebView(
                        userId: userId,
                      ))).then((value) {
            if (value is bool && value) {
              setState(() {
                isLoading = true;
              });
              getWorkout(userId);
            }
          });
        });
      } else {
        setState(() {
          savingEmail = false;
        });
        showToast('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        savingEmail = false;
      });
      showToast('Error' + 'Check Your Internet Connection');
    }
  }

  checkEmail(String userId) async {
    setState(() {
      savingEmail = true;
    });
    String apiUrl = ApiClient.urlCheckEmail;

    print('url $apiUrl');
    print('User Id $userId');

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': userId,
    }).catchError((value) {
      setState(() {
        savingEmail = false;
      });
      print('$value');
      showToast('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          print("checked true");
          savingEmail = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => C2WebView(
                      userId: userId,
                    ))).then((value) {
          if (value is bool && value) {
            setState(() {
              isLoading = true;
            });
            getWorkout(userId);
          }
        });
      } else {
        setState(() {
          savingEmail = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return groupDialog;
              });
            });
      }
    } else {
      setState(() {
        savingEmail = false;
      });
      showToast('Error' + 'Check Your Internet Connection');
    }
  }
}
