import 'package:us_rowing/models/ActivityModel.dart';

class ActivitiesResponse {
  late bool status;
  late String message;
  late List<ActivityModel> wrokoutDetails;

  ActivitiesResponse({required this.status, required this.message, required this.wrokoutDetails});

  ActivitiesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wrokoutDetails'] != null) {
      wrokoutDetails = [];
      json['wrokoutDetails'].forEach((v) {
        wrokoutDetails.add(new ActivityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['wrokoutDetails'] =
        this.wrokoutDetails.map((v) => v.toJson()).toList();
    return data;
  }
}