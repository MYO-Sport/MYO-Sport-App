import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AddressModel.dart';
import '../models/UserModel.dart';
import '../utils/AppConstants.dart';
import '../views/WelComeView.dart';

class SharedPrefs {
  static late SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<bool> isLogin() async {
    bool login = prefs.getBool(kLogin) ?? false;
    return login;
  }

  static Future<bool> pendingShare() async {
    bool status = prefs.getBool(kShare) ?? false;
    return status;
  }

  static Future<void> cancelShare() async {
    prefs.setBool(kShare, false);
  }

  static Future<void> activeShare() async {
    prefs.setBool(kShare, true);
  }

  static Future<void> saveUser(UserModel user) async {
    // prefs.clear();
    prefs.setBool(kLogin, true);
    prefs.setString(kUserName, user.username);
    prefs.setString(kUserMembership, user.memberNumber!);
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

  static Future<void> saveImage(String image) async {
    prefs.setBool(kLogin, true);
    prefs.setString(kPicture, image);
  }

  static Future<String?> getUserEmail() async {
    if (prefs.getKeys().contains('user_email')) {
      return prefs.getString(kEmail);
    } else {
      return '';
    }
  }

  static Future<UserModel> getUser() async {
    UserModel userModel =
        UserModel(address: AddressModel(), club: [], team: []);

    userModel.username = prefs.getString(kUserName) ?? '';
    userModel.memberNumber = prefs.getString(kUserMembership) ?? '';

    userModel.sId = prefs.getString(kUserId) ?? '';
    userModel.type = prefs.getString(kType) ?? '';
    userModel.contactNum = prefs.getString(kPhone) ?? '';
    userModel.profileImage = prefs.getString(kPicture) ?? '';
    userModel.email = prefs.getString(kEmail) ?? '';
    userModel.age = prefs.getInt(kAge) ?? 0;
    userModel.dob = prefs.getString(kDOB) ?? '';
    userModel.height = prefs.getInt(kHeight) ?? 0;
    userModel.weight = prefs.getInt(kWeight) ?? 0;
    userModel.port = prefs.getString(kPort) ?? '';
    userModel.starboard = prefs.getString(kStarboard) ?? '';
    userModel.sculling = prefs.getString(kSculling) ?? '';
    String city = prefs.getString(kCity) ?? '';
    String state = prefs.getString(kState) ?? '';
    userModel.address = AddressModel(city: city, state: state);
    return userModel;
  }

  static Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false);
  }
}
