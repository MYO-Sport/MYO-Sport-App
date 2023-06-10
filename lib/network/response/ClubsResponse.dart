
import 'package:us_rowing/models/ClubModel.dart';

class ClubsResponse {
  late bool status=true;
  late String message='Successful';
  late List<ClubModel> assignedClubs;
  late List<ClubModel> allClubs;

  ClubsResponse({required this.assignedClubs, required this.allClubs});

  ClubsResponse.fromJson(Map<String, dynamic> json) {
    if (json['assignedClubs'] != null) {
      assignedClubs = [];
      json['assignedClubs'].forEach((v) {
        assignedClubs.add(new ClubModel.fromJson(v));
      });
    }
    if (json['allClubs'] != null) {
      allClubs = [];
      json['allClubs'].forEach((v) {
        allClubs.add(new ClubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedClubs'] =
        this.assignedClubs.map((v) => v.toJson()).toList();
    data['allClubs'] = this.allClubs.map((v) => v.toJson()).toList();
    return data;
  }
}