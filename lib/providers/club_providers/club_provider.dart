import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:us_rowing/api_handler/api_handler.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/shared_prefs/shared_prefs.dart';

import '../../models/club/club_response.dart';

class ClubProvider extends ChangeNotifier {
  List<AllClub> _allClubs = [];
  List<AssignedClub> _assignedClub = [];
  String userID = '';
  bool isLoading = true;

  String get getCurrentUserID => this.userID;
  List<AllClub> get allClubs => this._allClubs;
  List<AssignedClub> get assignedClub => this._assignedClub;
  bool get getIsLoading => this.isLoading;

  getUserId() async {
    UserModel model = await SharedPrefs.getUser();
    userID = model.sId;
  }

  getClubs() async {
    var data = await ApiHandler.getClubsData();
    if (data != null) {
      isLoading = false;
      _allClubs = data.allClubs;
      _assignedClub = data.assignedClubs;
    } else {
      isLoading = false;
      Fluttertoast.showToast(msg: "NO Data Found");
    }
    notifyListeners();
    // print('userId' + userId);
  }
}
