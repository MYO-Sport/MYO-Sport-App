import 'package:us_rowing/models/ActivityModel.dart';

class HistoryModel {
  late String date;
  late String type;
  late String distance;
  late List<ActivityModel> activities;

  HistoryModel({required this.date, required this.distance, required this.activities,required this.type});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    type = json['type']??'MyoSport';
    distance = json['distance'];
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities.add(new ActivityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['type'] = this.type;
    data['distance'] = this.distance;
    data['activities'] = this.activities.map((v) => v.toJson()).toList();
    return data;
  }
}