import 'package:us_rowing/models/TeamModel.dart';

class TeamsResponse {
  bool status=true;
  String message='Successful';
  late List<TeamModel> assignedTeams;
  late List<TeamModel> allTeams;

  TeamsResponse({required this.assignedTeams, required this.allTeams});

  TeamsResponse.fromJson(Map<String, dynamic> json) {
    if (json['assignedTeams'] != null) {
      assignedTeams = [];
      json['assignedTeams'].forEach((v) {
        assignedTeams.add(new TeamModel.fromJson(v));
      });
    }
    if (json['allTeams'] != null) {
      allTeams = [];
      json['allTeams'].forEach((v) {
        allTeams.add(new TeamModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedTeams'] =
        this.assignedTeams.map((v) => v.toJson()).toList();
    data['allTeams'] = this.allTeams.map((v) => v.toJson()).toList();
    return data;
  }
}