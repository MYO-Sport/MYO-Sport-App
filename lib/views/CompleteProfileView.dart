import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/body/SignUpBody.dart';
import 'package:us_rowing/network/response/CompleteProfileResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/InputFields.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;

import 'CoachView/CoachHomeView.dart';
import 'AthleteView/HomeView.dart';

class CompleteProfileView extends StatefulWidget {
  final UserModel user;
  final bool update;

  CompleteProfileView({required this.user, required this.update});

  @override
  _CompleteProfileViewState createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  SignUpBody signUpBody = SignUpBody();

  bool isLoading = false;
  bool status = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController starboardController = TextEditingController();
  TextEditingController scullingController = TextEditingController();
  TextEditingController memberController = TextEditingController();
  late DateTime selectedDate;

  late String userName,
      age,
      dob,
      height,
      starboard,
      role,
      type,
      weight,
      port,
      sculling,
  memberNumber
  ;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    userNameController.text = widget.user.username;
    memberController.text = widget.user.memberNumber!;
    if (widget.update) {
      ageController.text =
          widget.user.age == 0 ? '' : widget.user.age.toString();
      dobController.text = getDate(widget.user.dob);
      heightController.text =
          widget.user.height == 0 ? '' : widget.user.height.toString();
      weightController.text =
          widget.user.weight == 0 ? '' : widget.user.weight.toString();
      portController.text = widget.user.port;
      starboardController.text = widget.user.starboard;
      scullingController.text = widget.user.sculling;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  color: colorPrimary,
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Skip',
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'MYO',
                              style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0),
                            ),
                            Text(
                              'SPORT',
                              style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0),
                            ),
                          ],
                        ),
                        InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                'Skip',
                                style: TextStyle(color: colorWhite),
                              ),
                            ),
                            onTap: () {
                              if(widget.update){
                                Navigator.of(context).pop();
                              }else{
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeView(userModel: widget.user)),
                                        (route) => false);
                              }
                            })
                      ],
                    )),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Complete Profile',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        text: 'Enter User Name',
                        type: TextInputType.name,
                        image: IMG_USERNAME,
                        enabled: false,
                        controller: userNameController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        text: 'Enter Membership Number',
                        type: TextInputType.number,
                        image: IMG_USERNAME,
                        enabled: true,
                        controller: memberController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.number,
                        text: 'Enter your Age',
                        image: IMG_AGE,
                        controller: ageController,
                        maxLength: 3,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InkWell(
                        child: InputField(
                          enabled: false,
                          text: 'Pick your DOB',
                          image: IMG_DOB,
                          controller: dobController,
                        ),
                        onTap: selectDate,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.number,
                        text: 'Enter Your Height (cm)',
                        image: IMG_HEIGHT,
                        controller: heightController,
                        maxLength: 3,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.number,
                        text: 'Enter Your Weight (kg)',
                        image: IMG_WEIGHT,
                        controller: weightController,
                        maxLength: 3,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        text: 'Enter Starboard',
                        image: IMG_STARBOARD,
                        controller: starboardController,
                        type: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        text: 'Enter Port',
                        image: IMG_PORT,
                        controller: portController,
                        type: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        text: 'Enter Sculling',
                        image: IMG_SCULLING,
                        controller: scullingController,
                        type: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    PrimaryButton(
                        text: 'Add',
                        onPressed: () {
                          hideKeyboard(context);
                          if (validate()) {
                            addProfile();
                          }
                        }),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
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
    userName = userNameController.text;
    age = ageController.text.trim();
    memberNumber = memberController.text;
    dob = dobController.text;
    height = heightController.text;
    starboard = starboardController.text;
    weight = weightController.text;
    port = portController.text;
    sculling = scullingController.text;
    if (userName.isEmpty) {
      MySnackBar.showSnackBar(context, "User Name is Required");
      return false;
    }
    if (age.isEmpty) {
      MySnackBar.showSnackBar(context, "Age is Required");
      return false;
    }
    if (dob.isEmpty) {
      MySnackBar.showSnackBar(context, "DOB is Required");
      return false;
    }
    if (starboard.isEmpty) {
      MySnackBar.showSnackBar(context, "Starboard no is Required");
      return false;
    }
    if (weight.isEmpty) {
      MySnackBar.showSnackBar(context, "Weight is Required");
      return false;
    }
    if (port.isEmpty) {
      MySnackBar.showSnackBar(context, "Port is Required");
      return false;
    }
    if (sculling.isEmpty) {
      MySnackBar.showSnackBar(context, "Sculling is Required");
      return false;
    }
    return true;
  }

  addProfile() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlUpdateProfile;

    print('UserId' + widget.user.sId);

    final response = await http.post(Uri.parse(apiUrl), body: {
      'name': userName,
      'age': age,
      'dob': dob,
      'height': height,
      'weight': weight,
      'port': port,
      'starboard': starboard,
      'sculling': sculling,
      'user_id': widget.user.sId,
      'membership_number' : memberNumber
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      print(response.body);
      final String responseString = response.body;
      CompleteProfileResponse mResponse =
          CompleteProfileResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        UserModel user = mResponse.saveUser;
        saveUser(user).then((value) {
          if (widget.update) {
            Navigator.of(context).pop(user);
          } else {
            if (user.type == typeAthlete) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeView(
                      userModel: user,
                    ),
                  ),
                  (route) => false);
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CoachHomeView(
                      userModel: user,
                    ),
                  ),
                  (route) => false);
            }
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(context, 'Error' + 'Check Your Internet Connection');
    }
  }

  String getDate(String str) {
    if (str.isNotEmpty) {
      DateTime date = DateTime.parse(str);
      return date.day.toString() +
          '-' +
          date.month.toString() +
          '-' +
          date.year.toString();
    }
    return '';
  }

  selectDate() async {
    hideKeyboard(context);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      dobController.text = picked.month.toString() +
          '-' +
          picked.day.toString() +
          '-' +
          picked.year.toString();
    }
  }
}
