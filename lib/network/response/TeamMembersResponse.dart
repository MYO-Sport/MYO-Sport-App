
import 'package:us_rowing/models/TeamMemberModel.dart';

class TeamMembersResponse {
  late bool status;
  late String message;
  late List<TeamMemberModel> team;

  TeamMembersResponse({required this.status, required this.message, required this.team});

  TeamMembersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['members'] != null) {
      team = [];
      json['members'].forEach((v) {
        team.add(new TeamMemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['members'] = this.team.map((v) => v.toJson()).toList();
    return data;
  }
}