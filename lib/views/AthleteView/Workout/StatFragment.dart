import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/StatModel.dart';
import 'package:us_rowing/models/WorkoutDataModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/WorkoutStatResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/TagWidget.dart';
import 'package:us_rowing/widgets/WorkOutWidget.dart';
import 'package:http/http.dart' as http;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StatFragment extends StatefulWidget {
  final bool isBack;

  StatFragment({this.isBack = true});

  @override
  _StatFragmentState createState() => _StatFragmentState();
}

class _StatFragmentState extends State<StatFragment> {
  bool isLoading = true;
  late WorkoutDataModel workoutData;

  late DateTime now;
  late DateTime selectedStartDate, selectedEndDate, selectedDate;
  late String userId;
  var formatter = new DateFormat('dd MMM');

  late Dialog sortDialog;
  late Dialog typeDialog;

  int _groupValue = 0;
  int _typeValue = 0;

  List<String> inputActivites = [];

  var typeBy = ['All', 'MyoSport', 'Strava', 'Concept2'];
  var sortBy = ['Range', 'Monthly', 'Yearly'];
  int sort = 0;
  int type = 0;


  List<String> selectedActivities = [];

  DateTimeRange? picked;

  String strDate = '';

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
    workoutData = WorkoutDataModel(
        activeTime: StatModel(total: "0", average: "0"),
        heartRate: StatModel(total: "0", average: "0"),
        steps: StatModel(total: "0", average: "0"),
        distance: StatModel(total: "0", average: "0"),
        calories: StatModel(total: "0", average: "0"),
        totalAscent: StatModel(total: "0", average: "0"));
    sortDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Container(
            height: 300.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Filter By:',
                    style: TextStyle(color: colorPrimary, fontSize: 18),
                  ),
                ),
                RadioListTile(
                  value: 0,
                  groupValue: _groupValue,
                  onChanged: (v) {
                    setState(() {
                      _groupValue = 0;
                    });
                  },
                  title: Text('Range'),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _groupValue,
                  onChanged: (v) {
                    setState(() {
                      _groupValue = 1;
                    });
                  },
                  title: Text('Month'),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _groupValue,
                  onChanged: (v) {
                    setState(() {
                      _groupValue = 2;
                    });
                  },
                  title: Text('Year'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: colorBlack, fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Done',
                            style: TextStyle(color: colorBlack, fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
    typeDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Container(
            height: 400.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Select Type:',
                    style: TextStyle(color: colorPrimary, fontSize: 18),
                  ),
                ),
                RadioListTile(
                  value: 0,
                  groupValue: _typeValue,
                  onChanged: (v) {
                    setState(() {
                      _typeValue = 0;
                    });
                  },
                  title: Text('All'),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _typeValue,
                  onChanged: (v) {
                    setState(() {
                      _typeValue = 1;
                    });
                  },
                  title: Text('MyoSport'),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _typeValue,
                  onChanged: (v) {
                    setState(() {
                      _typeValue = 2;
                    });
                  },
                  title: Text('Strava'),
                ),
                RadioListTile(
                  value: 3,
                  groupValue: _typeValue,
                  onChanged: (v) {
                    setState(() {
                      _typeValue = 3;
                    });
                  },
                  title: Text('Concept2'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: colorBlack, fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Done',
                            style: TextStyle(color: colorBlack, fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getWorkoutStat(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackgroundLight,
        body: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
                )),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10, top: 20.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
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
                                      '${typeBy[type]}',
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
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        typeDialog).then((value) {
                                  if (value is bool &&
                                      value &&
                                      type != _typeValue) {
                                    setState(() {
                                      type = _typeValue;
                                      isLoading = true;
                                    });
                                    getWorkoutStat(userId);
                                  }
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
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
                                      '${sortBy[sort]}',
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
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        sortDialog).then((value) {
                                  if (value is bool &&
                                      value &&
                                      sort != _groupValue) {
                                    if (_groupValue == 0) {
                                      setState(
                                        () {
                                          sort = _groupValue;
                                          selectedStartDate =
                                              now.subtract(Duration(days: 15));
                                          selectedEndDate = now;
                                          strDate = formatter
                                                  .format(selectedStartDate) +
                                              '-' +
                                              formatter.format(selectedEndDate);
                                          isLoading = true;
                                        },
                                      );
                                      getWorkoutStat(userId);
                                    } else if (_groupValue == 1) {
                                      setState(() {
                                        sort = _groupValue;
                                        selectedStartDate = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            1);
                                        selectedEndDate = DateTime(
                                            selectedDate.year,
                                            selectedDate.month + 1,
                                            0);
                                        var monthFormatter =
                                            new DateFormat('MMMM');
                                        strDate =
                                            monthFormatter.format(selectedDate);
                                        isLoading = true;
                                      });
                                      getWorkoutStat(userId);
                                    } else if (_groupValue == 2) {
                                      setState(() {
                                        sort = _groupValue;
                                        selectedStartDate =
                                            DateTime(selectedDate.year, 1, 1);
                                        selectedEndDate =
                                            DateTime(selectedDate.year, 12, 31);
                                        var yearFormatter =
                                            new DateFormat('yyyy');
                                        strDate =
                                            yearFormatter.format(selectedDate);
                                        isLoading = true;
                                      });
                                      getWorkoutStat(userId);
                                    }
                                  }
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
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
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              if (sort == 0) {
                                picked = await showDateRangePicker(
                                  context: context,
                                  firstDate:
                                      new DateTime(DateTime.now().year - 10),
                                  lastDate: now,
                                );
                                if (picked != null) {
                                  setState(
                                    () {
                                      selectedStartDate = picked!.start;
                                      selectedEndDate = picked!.end;
                                      strDate =
                                          formatter.format(selectedStartDate) +
                                              '-' +
                                              formatter.format(selectedEndDate);
                                      isLoading = true;
                                    },
                                  );
                                  getWorkoutStat(userId);
                                }
                              } else if (sort == 1) {
                                showMonthPicker(
                                  context: context,
                                  firstDate:
                                      DateTime(DateTime.now().year - 1, 5),
                                  lastDate: now,
                                  initialDate: selectedDate,
                                  locale: Locale("en"),
                                ).then((date) {
                                  if (date != null) {
                                    print('selected date: $date');
                                    setState(() {
                                      selectedDate = date;
                                      selectedStartDate =
                                          DateTime(date.year, date.month, 1);
                                      selectedEndDate = DateTime(
                                          date.year, date.month + 1, 0);
                                      var monthFormatter =
                                          new DateFormat('MMMM');
                                      strDate =
                                          monthFormatter.format(selectedDate);
                                      isLoading = true;
                                    });
                                    getWorkoutStat(userId);
                                  }
                                });
                              } else if (sort == 2) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Select Year"),
                                      content: Container(
                                        // Need to use container to add size constraint.
                                        width: 300,
                                        height: 300,
                                        child: YearPicker(
                                          firstDate: DateTime(
                                              DateTime.now().year - 100, 1),
                                          lastDate: now,
                                          initialDate: selectedDate,
                                          // save the selected date to _selectedDate DateTime variable.
                                          // It's used to set the previous selected date when
                                          // re-showing the dialog.
                                          selectedDate: selectedStartDate,
                                          onChanged: (DateTime dateTime) {
                                            // close the dialog when year is selected.
                                            print('selected date: $dateTime');
                                            setState(() {
                                              selectedDate = dateTime;
                                              selectedStartDate =
                                                  DateTime(dateTime.year, 1, 1);
                                              selectedEndDate = DateTime(
                                                  dateTime.year, 12, 31);
                                              var yearFormatter =
                                                  new DateFormat('yyyy');
                                              strDate = yearFormatter
                                                  .format(selectedDate);
                                              isLoading = true;
                                            });
                                            getWorkoutStat(userId);
                                            Navigator.pop(context);

                                            // Do something with the dateTime selected.
                                            // Remember that you need to use dateTime.year to get the year
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Sort by Activities.'),
                      ),
                      suggestionsCallback: (pattern) {
                        List<String> matches = <String>[];
                        matches.addAll(activities);

                        matches.retainWhere((s) =>
                            s.toLowerCase().contains(pattern.toLowerCase()));
                        return matches;
                      },
                      itemBuilder: (context, String suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                          subtitle: Text(''),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        if (!selectedActivities.contains(suggestion)) {
                          setState(() {
                            selectedActivities.add(suggestion);
                            isLoading = true;
                          });
                          getWorkoutStat(userId);
                        }
                      },
                    ),
                  ),
                  selectedActivities.length == 0
                      ? SizedBox()
                      : Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: selectedActivities.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String _item = selectedActivities[index];
                                return TagWidget(
                                  index: index,
                                  last: selectedActivities.length - 1,
                                  title: _item,
                                  onRemove: () {
                                    setState(() {
                                      selectedActivities.removeAt(index);
                                      isLoading = true;
                                    });
                                    getWorkoutStat(userId);
                                  },
                                );
                              }),
                        ),
                  Expanded(
                      child: GridView(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.35),
                    children: [
                      WorkOutWidget(
                        image: 'assets/images/workouts/heart-rate.png',
                        countDown: workoutData.heartRate.average,
                        workout: 'Heart Rate',
                        unit: 'bpm',
                      ),
                      WorkOutWidget(
                        image: 'assets/images/workouts/calories.png',
                        countDown: workoutData.calories.total,
                        workout: 'Calories',
                        unit: 'kcal',
                      ),
                      WorkOutWidget(
                        image: 'assets/images/workouts/ascents.png',
                        countDown: workoutData.totalAscent.total,
                        workout: 'Ascent',
                        unit: 'meter',
                      ),
                      WorkOutWidget(
                        image: 'assets/images/workouts/steps.png',
                        countDown: workoutData.steps.total,
                        workout: 'Steps',
                        unit: 'steps',
                      ),
                      WorkOutWidget(
                        image: 'assets/images/workouts/distance.png',
                        countDown: workoutData.distance.total,
                        workout: 'Distance',
                        unit: 'km',
                      ),
                      WorkOutWidget(
                        image: 'assets/images/workouts/time.png',
                        countDown: workoutData.activeTime.total,
                        workout: 'Active Time',
                        unit: 'hh:mm:ss',
                      ),
                    ],
                  )),
                ],
              ));
  }

  getWorkoutStat(String userId) async {
    inputActivites.clear();
    print('User Id $userId');
    String apiUrl = ApiClient.urlGetWorkoutStats;

    String strType;

    if (selectedActivities.length == 0) {
      inputActivites.addAll(activities);
    } else {
      inputActivites.addAll(selectedActivities);
    }

    /*if(type==0){
    strType='all';
    }else if(type==1){
      strType='myo';
    }else if(type==2){
      strType='strava';
    }else if(type==3){
      strType='concept2';
    }else{
    strType='all';
    }*/

    strType = type.toString();

    String strStartDate =
        '${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}';
    String strEndDate =
        '${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}';

    print('url $apiUrl');
    print('User Id: $userId');
    print('Start Date: $strStartDate');
    print('End Date: $strEndDate');
    print('Type: $strType');

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': userId,
      'start_date': strStartDate,
      'end_date': strEndDate,
      'type': strType,
      'workout_type': json.encode(inputActivites)
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      return value;
      // showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      WorkoutStatResponse mResponse =
          WorkoutStatResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          workoutData = mResponse.averageOfAllWorkouts;
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
      // showSnackBar(context, 'Error' + 'Check Your Internet Connection');
    }
  }

  // ignore: non_constant_identifier_names
  String k_m_b_generator(String str) {
    double num;
    try {
      num = double.parse(str);
    } catch (e) {
      print(e);
      return str;
    }

    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} kil";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} mil";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} bil";
    } else {
      return num.toString();
    }
  }
}
