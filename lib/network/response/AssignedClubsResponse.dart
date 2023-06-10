
import 'package:us_rowing/models/ClubModel.dart';

class AssignedClubsResponse {
  late bool status=true;
  late String message='Successful';
  late List<ClubModel> assignedClubs;

  AssignedClubsResponse({required this.assignedClubs});

  AssignedClubsResponse.fromJson(Map<String, dynamic> json) {
    if (json['assignedClubs'] != null) {
      assignedClubs = [];
      json['assignedClubs'].forEach((v) {
        assignedClubs.add(new ClubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedClubs'] =
        this.assignedClubs.map((v) => v.toJson()).toList();
    return data;
  }
}