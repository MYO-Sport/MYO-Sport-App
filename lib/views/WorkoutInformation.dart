import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/ActivityModel.dart';
import 'package:us_rowing/models/WorkOutActivitiesModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/body/WorkoutBody.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'dart:io' as i;
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/DateInputField.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:us_rowing/widgets/SelectImageSheet.dart';
import 'package:us_rowing/widgets/SimpleInputField.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:us_rowing/widgets/SimpleTimeField.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:us_rowing/widgets/TimeInputField.dart';
import 'package:us_rowing/widgets/TimePickBottom.dart';

class WorkoutInformation extends StatefulWidget {
  final List<WorkOutActivities> activities;
  final String workoutId;

  WorkoutInformation({required this.activities, required this.workoutId});

  @override
  _WorkoutInformationState createState() => _WorkoutInformationState();
}

class _WorkoutInformationState extends State<WorkoutInformation> {
  bool selectImage = true;
  late i.File _image;

  List<TextEditingController> controllers = [];

  late WorkoutBody bodyWorkout;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String dateTime = '';
  late String selectedValue;

  String userId = '';

  bool isLoading = false;

  List<ActivityModel> activities = [];

  late DateTime now;
  String strNow = '';

  String strDate = '';

  Future getImage() async {
    final picker = ImagePicker();
    print('Going to capture image');
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = i.File(pickedFile.path);
        selectImage = false;
      } else {
        print('No image selected');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    String dateFormatter = now.toIso8601String();
    DateTime dt = DateTime.parse(dateFormatter);
    var formatter = new DateFormat('MM-dd-yyyy');
    strNow = formatter.format(dt);
    for (int i = 0; i < widget.activities.length; i++) {
      if (widget.activities[i].valueType == typeDate) {
        controllers.add(new TextEditingController(text: strNow));
      } else {
        controllers.add(new TextEditingController());
      }
    }
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: colorBackgroundLight,
            appBar: SimpleToolbar(
              title: 'Workout Detail',
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.activities.length,
                    itemBuilder: (context, index) {
                      WorkOutActivities activity = widget.activities[index];
                      if (activity.valueType == typeDouble) {
                        return WorkOutInfoWidget(
                          heading: activity.activityName,
                          controller: controllers[index],
                        );
                      } else if (activity.valueType == typeDate) {
                        // controllers[index].text=strNow;
                        return DateInputField(
                          heading: activity.activityName,
                          controller: controllers[index],
                          onTap: () async {
                            DateTime date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            date = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100)))!;
                            String dateFormatter = date.toIso8601String();
                            DateTime dt = DateTime.parse(dateFormatter);
                            var formatter = new DateFormat('MM-dd-yyyy');
                            controllers[index].text = formatter.format(dt);
                          },
                        );
                      }
                      if (activity.valueType == typeTime) {
                        return TimeInputField(
                          heading: activity.activityName,
                          controller: controllers[index],
                          onTap: () async {
                            hideKeyboard(context);
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: colorWhite,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                builder: (BuildContext builder) {
                                  return TimePickBottom(onPick: (duration) {
                                    controllers[index].text = duration;
                                  });
                                });
                          },
                        );
                      } else {
                        return Text('Undefined Activity');
                      }
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  selectImage
                      ? InkWell(
                          child: DottedBorder(
                            color: colorBlack,
                            strokeWidth: 2,
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.125,
                                width: MediaQuery.of(context).size.width * 0.8,
                                color: colorWhite,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40.0,
                                      color: colorPrimary,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Upload workout picture',
                                      style: TextStyle(color: colorPrimary),
                                    ),
                                  ],
                                )),
                          ),
                          onTap: () {
                            hideKeyboard(context);
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Wrap(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: SelectImageSheet(
                                            onAdd: onAdd,
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Image.file(_image, fit: BoxFit.cover),
                        ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: PrimaryButton(
                      text: 'SUBMIT',
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      radius: 10,
                      startColor: colorPrimary,
                      endColor: colorPrimary,
                      onPressed: () {
                        if (validate()) {
                          uploadWorkout();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            )),
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.black38,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorBlue),
                )),
              )
            : Container()
      ],
    );
  }

  bool validate() {
    activities.clear();
    for (int i = 0; i < widget.activities.length; i++) {
      String text = controllers[i].text;
      print(text);
      if (widget.activities[i].valueType == typeDate) {
        strDate = controllers[i].text;
        try {
          List<String> dates = strDate.split('-');
          DateTime nowUTC = now.toUtc();
          DateTime dateTime = DateTime.utc(
              int.parse(dates[2]),
              int.parse(dates[0]),
              int.parse(dates[1]),
              nowUTC.hour,
              nowUTC.minute,
              nowUTC.second,
              nowUTC.millisecond,
              nowUTC.microsecond);
          strDate = dateTime.toString();
        } catch (e) {
          strDate = '';
        }
      }
      if (widget.activities[i].isRequired == '1' && text.isEmpty) {
        MySnackBar.showSnackBar(
            context, widget.activities[i].activityName + ' is Required');
        return false;
      }
      ActivityModel activity = ActivityModel(
        activityId: widget.activities[i].sId,
        activityName: widget.activities[i].activityName,
        value: text,
        valType: widget.activities[i].valueType,
        unit: widget.activities[i].unit,
      );
      activities.add(activity);
    }
    /*if(imageSelected){
      showSnackBar(context, 'Image is Required');
      return false;
    }*/
    bodyWorkout = WorkoutBody(
        userId: userId, workoutId: widget.workoutId, activities: activities);
    return true;
  }

  addWorkout() async {
    print('User Id $userId');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlAddWorkout;

    final response = await http
        .post(Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(bodyWorkout))
        .catchError((value) {
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
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading = false;
        });
        showToast('Workout Added Successfully');
        Navigator.of(context).pop();
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

  onAdd(i.File file) {
    print('On Add is called in my club feed');

    setState(() {
      _image = file;
      selectImage = false;
    });
  }

  uploadWorkout() async {
    print('updating image');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlAddWorkout;

    print('Url: $apiUrl');
    print('workout_id: ${widget.workoutId}');
    print('date: $strDate');
    print('activities ${json.encode(activities)}');

    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
    request.fields['user_id'] = userId;
    request.fields['workout_id'] = widget.workoutId;
    request.fields['activities'] = json.encode(activities);
    request.fields['date'] = strDate;
    if (!selectImage) {
      request.files.add(new http.MultipartFile.fromBytes(
          'workout_image', await _image.readAsBytes(),
          filename: path.basename(_image.path)));
    }
    request.send().then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        getResponse(response);
      } else {
        getError(response);
      }
    }).catchError((error) {
      print('Error: ' '$error');
      MySnackBar.showSnackBar(context, 'Error: Check Your Internet Connection');
    });
  }

/*   String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  } */

  getResponse(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    GeneralStatusResponse mResponse =
        GeneralStatusResponse.fromJson(json.decode(response.body));
    if (mResponse.status) {
      setState(() {
        isLoading = false;
      });
      showToast('Workout Added Successfully');
      Navigator.of(context).pop();
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
    }
  }

  getError(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    MySnackBar.showSnackBar(context, 'Error: Check Your Internet Connection');
  }
}

class WorkOutInfoWidget extends StatelessWidget {
  final String heading;
  final TextEditingController controller;

  WorkOutInfoWidget({required this.heading, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              heading,
              style: TextStyle(fontSize: 12.0, color: colorBlack),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            color: colorWhite,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: SimpleInputField(
                text: 'Enter ' + heading,
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutTimeWidget extends StatelessWidget {
  final String heading;
  final TextEditingController controller;

  WorkoutTimeWidget({required this.heading, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              heading,
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: SimpleTimeField(
                text: 'Enter ' + heading + ('(hh:mm:ss)'),
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
