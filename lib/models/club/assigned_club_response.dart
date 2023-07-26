// To parse this JSON data, do
//
//     final assignedClubsResponse = assignedClubsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:us_rowing/models/club/club_response.dart';

AssignedClubsResponse assignedClubsResponseFromJson(String str) =>
    AssignedClubsResponse.fromJson(json.decode(str));

String assignedClubsResponseToJson(AssignedClubsResponse data) =>
    json.encode(data.toJson());

class AssignedClubsResponse {
  bool status;
  List<AssignedClub> assignedClubs;

  AssignedClubsResponse({
    required this.status,
    required this.assignedClubs,
  });

  factory AssignedClubsResponse.fromJson(Map<String, dynamic> json) =>
      AssignedClubsResponse(
        status: json["status"],
        assignedClubs: List<AssignedClub>.from(
            json["assignedClubs"].map((x) => AssignedClub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "assignedClubs":
            List<dynamic>.from(assignedClubs.map((x) => x.toJson())),
      };
}
