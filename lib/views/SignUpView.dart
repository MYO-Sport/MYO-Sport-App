import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/body/SignUpBody.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CompleteProfileView.dart';
// import 'package:us_rowing/views/EmailVerification.dart';
import 'package:us_rowing/views/LoginView.dart';
import 'package:us_rowing/widgets/InputFields.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;

class SignUpView extends StatefulWidget {
  final String type;

  SignUpView({required this.type});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpBody signUpBody = SignUpBody();

  bool isLoading = false;
  bool status = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController memberShipController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();

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
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Sign Up as ' + widget.type,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorBlack, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.name,
                        text: 'Enter User Name',
                        image: IMG_USERNAME,
                        controller: userNameController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.emailAddress,
                        text: 'Enter your Email',
                        image: IMG_EMAIL,
                        controller: emailController,
                        maxLength: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.number,
                        text: 'Enter Membership Number',
                        image: IMG_USERNAME,
                        controller: memberShipController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
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
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.visiblePassword,
                        text: 'Confirm Password',
                        image: IMG_PASSWORD,
                        obscureText: true,
                        controller: conPasswordController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.number,
                        text: 'Enter your contact no',
                        image: IMG_PHONE,
                        controller: contactNoController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.name,
                        text: 'Enter your city name',
                        image: IMG_CITY,
                        controller: cityNameController,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: InputField(
                        type: TextInputType.name,
                        text: 'Enter your state name',
                        image: IMG_STATE,
                        controller: stateNameController,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Flexible(
                            child: Text(
                              'I agree to the Term and Conditions And the Privacy Policy',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colorDarkBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    PrimaryButton(
                        text: 'REGISTER',
                        onPressed: () {
                          hideKeyboard(context);
                          if (validate()) {
                            signUp();
                          }
                        }),
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
                              'Have an Account ?',
                              style: TextStyle(
                                  color: colorDarkRed,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView(
                                          type: widget.type,
                                        )),
                              );
                            },
                          ),
                          InkWell(
                            child: Text(
                              ' LOGIN NOW',
                              style: TextStyle(
                                  color: colorDarkBlue,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView(
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
    String userName = userNameController.text;
    String email = emailController.text.trim();
    String password = passwordController.text;
    String conPassword = conPasswordController.text;
    String contact = contactNoController.text;
    String role = 'user';
    String type = widget.type;
    String city = cityNameController.text;
    String state = stateNameController.text;
    String memberNumber = memberShipController.text;
    if (userName.isEmpty) {
      MySnackBar.showSnackBar(context, "User Name is Required");
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
    if (password != conPassword) {
      MySnackBar.showSnackBar(context, "Passwords didn\'t match");
      return false;
    }
    if (contact.isEmpty) {
      MySnackBar.showSnackBar(context, "Contact no is Required");
      return false;
    }
    if (city.isEmpty) {
      MySnackBar.showSnackBar(context, "City name is Required");
      return false;
    }
    if (state.isEmpty) {
      MySnackBar.showSnackBar(context, "State name is Required");
      return false;
    }
    if (!status) {
      MySnackBar.showSnackBar(context, "Accept the Terms and Conditions.");
      return false;
    }
    signUpBody.username = userName;
    signUpBody.memberNumber = memberNumber;
    signUpBody.type = type;
    signUpBody.contactNum = contact;
    signUpBody.role = role;
    signUpBody.email = email;
    signUpBody.city = city;
    signUpBody.state = state;
    signUpBody.password = conPassword;
    return true;
  }

  /*signUp() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlVerifyEmail;

    final response = await http
        .post(Uri.parse(apiUrl),
            body: {
          'email':signUpBody.email
            })
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Error: ' + 'Check Your Internet Connection.');
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading=false;
        });
        showToast('Verify Your Email');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailVerification( body: signUpBody)));
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    }
  }*/

  signUp() async {
    String apiUrl = ApiClient.urlSignUp;

    setState(() {
      isLoading = true;
    });

    final response = await http
        .post(Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(signUpBody))
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection.');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        // UserModel model = UserModel(address: signUpBody., club: club, team: team)
        setState(() {
          isLoading = false;
        });
        UserModel model = UserModel.abc(username: signUpBody.username, email: signUpBody.email);

 /*        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EmailVerification(email: signUpBody.email)));  */
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompleteProfileView(user: model, update: false,)));
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
          context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
