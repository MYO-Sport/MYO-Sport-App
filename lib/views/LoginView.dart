import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/body/LoginBody.dart';
import 'package:us_rowing/network/response/UserResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CoachView/CoachHomeView.dart';
import 'package:us_rowing/views/ForgotPasswordView.dart';
import 'package:us_rowing/views/SignUpView.dart';
import 'package:us_rowing/widgets/InputFields.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;

import 'AthleteView/HomeView.dart';
// import 'EmailVerification.dart';

class LoginView extends StatefulWidget {
  final String type;
  LoginView({required this.type});
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginBody loginBody;

  bool isLoading = false;
  bool status = true;
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
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
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      'Login as ' + widget.type,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorBlack, fontSize: 16),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        maxLength: 30,
                        type: TextInputType.emailAddress,
                        text: 'Enter your email',
                        image: IMG_USERNAME,
                        controller: userEmailController,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.visiblePassword,
                        text: 'Enter your Password',
                        image: IMG_PASSWORD,
                        obscureText: true,
                        controller: passwordController,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlutterSwitch(
                            width: 55.0,
                            height: 25.0,
                            valueFontSize: 8.0,
                            inactiveColor: colorWhite,
                            activeColor: colorBlue,
                            toggleColor: status ? colorWhite : colorGrey,
                            inactiveTextColor: colorGrey,
                            toggleSize: 15.0,
                            inactiveSwitchBorder: Border.all(color: colorGrey),
                            value: status,
                            borderRadius: 25.0,
                            padding: 5.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                                fontSize: 10,
                                color: colorDarkBlue,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: colorBlue, width: 1))),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: colorDarkBlue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordView(
                                      type: widget.type,
                                    )),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    PrimaryButton(
                      text: 'LOGIN',
                      onPressed: () {
                        hideKeyboard(context);
                        if (validate()) {
                          logIn();
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  color: colorDarkRed,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpView(
                                          type: widget.type,
                                        )),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
    String email = userEmailController.text.trim();
    String password = passwordController.text;
    if (email.isEmpty) {
      MySnackBar.showSnackBar(context, "Email is Required");
      return false;
    }
    if (!validEmail(email)) {
      MySnackBar.showSnackBar(context, "Correct Email is Required");
      return false;
    }
    if (password.isEmpty) {
      MySnackBar.showSnackBar(context, "Password is Required");
      return false;
    }

    int status;
    if (widget.type == typeAthlete) {
      status = 0;
    } else {
      status = 1;
    }

    loginBody = LoginBody(status: status);
    loginBody.email = email.toLowerCase();
    print(email.toLowerCase());
    loginBody.password = password;
    return true;
  }

  logIn() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlLogin;

    await http
        .post(Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(loginBody))
        .then((response) {
      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(response.body);
        UserResponse mResponse =
            UserResponse.fromJson(json.decode(responseString));
        if (mResponse.status) {
          // if(mResponse.verified){
          UserModel user = mResponse.response;
          saveUser(user).then((value) {
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
          });
          /*  }
          else{
            setState(() {
              isLoading=false;
            });
            showToast('Please Verify Your Account');
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailVerification( email: loginBody.email)));
          } */
        } else {
          setState(() {
            isLoading = false;
          });
          MySnackBar.showSnackBar(context, mResponse.message);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.body);
        MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
      }
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    });
  }
}
