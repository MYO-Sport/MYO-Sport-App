import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/MySnackBar.dart';

import 'ResetPassword.dart';

class OTPVerification extends StatefulWidget {
  final String email;
  OTPVerification({required this.email});
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();

  String email='';
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
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
                SizedBox(height: MediaQuery.of(context).size.height *0.1),
                Text(
                  'OTP Verification',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 25.0,),
                Text(
                  'Enter you One Time Password',
                  style: TextStyle(fontWeight: FontWeight.w500,color: colorGrey),
                ),
                Text(
                  'to change your password.',
                  style: TextStyle(fontWeight: FontWeight.w500,color: colorGrey),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                OTPTextField(
                  length: 6,
                  fieldWidth: MediaQuery.of(context).size.width*0.13,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.center,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    otpVerification(pin);
                  },
                ),
                SizedBox(
                  height: 55.0,
                ),
                /*PrimaryButton(
                  text: 'CONTINUE',
                  onPressed: () {
                    if(validate()){
                      otpVerification();
                    }
                  },
                ),*/
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

  bool validate(){
    email=emailController.text;
    if(!validEmail(email)){
      MySnackBar.showSnackBar(context, 'Correct Email is Required');
      return false;
    }
    return true;
  }

  otpVerification(String otp) async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlVerifyOtp;

    final response = await http
        .post(Uri.parse(apiUrl),
        body: {
          'email':widget.email,
          'otp': otp
        })
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
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
        showToast('Set Your New Password');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResetPasswordView(email: widget.email)));
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    }
  }
}
