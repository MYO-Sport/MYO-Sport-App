import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/api_handler/responses/equipment_feedback_response.dart';
import 'package:us_rowing/utils/AppUtils.dart';

import '../models/UserModel.dart';
import '../models/club/club_response.dart';
import '../network/ApiClient.dart';
import '../shared_prefs/shared_prefs.dart';

class ApiHandler {
// API Method for fetching clubs from server
  static Future<ClubsResponse?> getClubsData() async {
    ClubsResponse? clubData;
    // print('userId' + userId);
    UserModel model = await SharedPrefs.getUser();

    String apiUrl = ApiClient.urlGetClubs + model.sId;

    try {
      final response = await http
          .post(
        Uri.parse(apiUrl),
      )
          .catchError((value) {
        // notifyListeners();
        // MySnackBar.showSnackBar(
        //     context, 'Error: ' + 'Check Your Internet Connection');
        throw value;
      });

      if (response.statusCode == 200) {
        clubData = clubsResponseFromJson(response.body);

        // notifyListeners();
      } else {
        Fluttertoast.showToast(msg: 'Error: ${response.statusCode}');
        // notifyListeners();
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
    return clubData;
  }

  static sendEquipmentFeedback(
      String userID, String equipmentID, String feedback, double rating) async {
    String apiUrl = ApiClient.sendEquipmentFeedback;

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'user_id': userID,
        'equipment_id': equipmentID,
        'equipment_feedback': feedback,
        'rating': rating.toString()
      });

      if (response.statusCode == 200) {
        var data = equipmentFeedbackResponseFromJson(response.body);
        if (data.status) {
          showToast(data.message);
        }

        // notifyListeners();
      } else {
        Fluttertoast.showToast(msg: 'Error: ${response.statusCode}');
        // notifyListeners();
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
      throw e;
    }
  }
}
