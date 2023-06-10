import 'package:us_rowing/models/TeamModel.dart';

class ClubTeamsResponse {
  bool status=true;
  String message='Successful';
  late List<TeamModel> assignedTeams;
  late List<TeamModel> allTeams;

  ClubTeamsResponse({required this.assignedTeams, required this.allTeams});

  ClubTeamsResponse.fromJson(Map<String, dynamic> json) {
    if (json['assigned_teams'] != null) {
      assignedTeams = [];
      json['assigned_teams'].forEach((v) {
        assignedTeams.add(new TeamModel.fromJson(v));
      });
    }
    if (json['all_teams'] != null) {
      allTeams = [];
      json['all_teams'].forEach((v) {
        allTeams.add(new TeamModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assigned_teams'] =
        this.assignedTeams.map((v) => v.toJson()).toList();
    data['all_teams'] = this.allTeams.map((v) => v.toJson()).toList();
    return data;
  }
}