
import 'package:us_rowing/models/CoachModel.dart';

class CoachesResponse {
  bool status= true;
  String message='Successful';
  late List<CoachModel> assignedCoaches;
  late List<CoachModel> allCoaches;

  CoachesResponse({required this.assignedCoaches, required this.allCoaches});

  CoachesResponse.fromJson(Map<String, dynamic> json) {
    if (json['assignedCoaches'] != null) {
      assignedCoaches = [];
      json['assignedCoaches'].forEach((v) {
        assignedCoaches.add(new CoachModel.fromJson(v));
      });
    }
    if (json['allCoaches'] != null) {
      allCoaches = [];
      json['allCoaches'].forEach((v) {
        allCoaches.add(new CoachModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedCoaches'] =
        this.assignedCoaches.map((v) => v.toJson()).toList();
    data['allCoaches'] = this.allCoaches.map((v) => v.toJson()).toList();
    return data;
  }
}