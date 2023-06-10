import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:us_rowing/models/AddressModel.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/views/WelComeView.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r"^\d*\.?\d*");
    String newString = regEx.stringMatch(newValue.text) ?? "";
    return newString == newValue.text ? newValue : oldValue;
  }
}

showToast(String str){
  Fluttertoast.showToast(msg: str);
}



bool validEmail(String text){
  if(text.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text)){
    return true;
  }else{
    return false;
  }
}

hideKeyboard(BuildContext context){
  FocusScope.of(context).unfocus();
}

Future<bool> isLogin() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool login=prefs.getBool(kLogin)??false;
  return login;
}

Future<bool> pendingShare() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status=prefs.getBool(kShare)??false;
  return status;
}

Future<void> cancelShare() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(kShare, false);
}

Future<void> activeShare() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(kShare, true);
}


Future<void> saveUser(UserModel user) async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setBool(kLogin, true);
  prefs.setString(kUserName, user.username);
  prefs.setString(kUserMembership, user.memberNumber);
  prefs.setString(kEmail, user.email);
  prefs.setString(kUserId, user.sId);
  prefs.setString(kPhone, user.contactNum);
  prefs.setString(kType, user.type);
  prefs.setString(kPicture, user.profileImage);
  prefs.setInt(kAge, user.age);
  prefs.setString(kDOB, user.dob);
  prefs.setInt(kHeight, user.height);
  prefs.setInt(kWeight, user.weight);
  prefs.setString(kPort, user.port);
  prefs.setString(kStarboard, user.starboard);
  prefs.setString(kSculling, user.sculling);
  prefs.setString(kState, user.address.state);
  prefs.setString(kCity, user.address.city);
}

Future<void> saveImage(String image) async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  prefs.setBool(kLogin, true);
  prefs.setString(kPicture, image);
}

Future<UserModel> getUser() async{
  UserModel userModel=UserModel(address: AddressModel(), club: [], team: []);
  SharedPreferences prefs=await SharedPreferences.getInstance();
  userModel.username=prefs.getString(kUserName)??'';
  userModel.memberNumber=prefs.getString(kUserMembership)??'';
  userModel.sId=prefs.getString(kUserId)??'';
  userModel.type=prefs.getString(kType)??'';
  userModel.contactNum=prefs.getString(kPhone)??'';
  userModel.profileImage=prefs.getString(kPicture)??'';
  userModel.email=prefs.getString(kEmail)??'';
  userModel.age=prefs.getInt(kAge)??0;
  userModel.dob=prefs.getString(kDOB)??'';
  userModel.height=prefs.getInt(kHeight)??0;
  userModel.weight=prefs.getInt(kWeight)??0;
  userModel.port=prefs.getString(kPort)??'';
  userModel.starboard=prefs.getString(kStarboard)??'';
  userModel.sculling=prefs.getString(kSculling)??'';
  String city=prefs.getString(kCity)??'';
  String state=prefs.getString(kState)??'';
  userModel.address=AddressModel(city: city,state: state);
  return userModel;
}


Future<void> logout(BuildContext context) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.clear();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> WelcomeView()), (route) => false);
}