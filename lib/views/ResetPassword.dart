import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/InputFields.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;

class ResetPasswordView extends StatefulWidget {
  final String email;
  ResetPasswordView({required this.email});
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController= TextEditingController();

  String password='';
  String conPassword='';
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
                  'Reset Password',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: InputField(
                    obscureText: true,
                    text: 'New Password',
                    image: IMG_PASSWORD,
                    controller: passwordController,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: InputField(
                    obscureText: true,
                    text: 'Confirm Password',
                    image: IMG_PASSWORD,
                    controller: conPasswordController,
                  ),
                ),
                SizedBox(
                  height: 55.0,
                ),
                PrimaryButton(
                  text: 'CONTINUE',
                  onPressed: () {
                    hideKeyboard(context);
                    if(validate()){
                      forgotPassword();
                    }
                  },
                ),
                SizedBox(
                  height: 50.0,
                ),
                InkWell(
                  child: Text(
                    'Back to My App',
                    style: TextStyle(
                        color: colorBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
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

  bool validate(){
    password=passwordController.text;
    conPassword=conPasswordController.text;
    if(password.isEmpty){
      MySnackBar.showSnackBar(context, 'Password is Required');
      return false;
    }

    if(password!=conPassword){
      MySnackBar.showSnackBar(context, 'Passwords didn\'t match.');
      return false;
    }

    return true;
  }

  forgotPassword() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlResetPassword;

    final response = await http
        .post(Uri.parse(apiUrl),
        body: {
          'email':widget.email,
          'password':password
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
        showToast('Your Password is Reset Successfully.');
        Navigator.of(context).pop();
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
