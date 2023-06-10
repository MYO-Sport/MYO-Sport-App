import 'package:us_rowing/models/TeamMembersInfoModel.dart';

class TeamInfoModel {
  late String teamName;
  late List<TeamMembersInfoModel> teamMembersInfo;

  TeamInfoModel({this.teamName='', required this.teamMembersInfo});

  TeamInfoModel.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    if (json['team_members_info'] != null) {
      teamMembersInfo = <TeamMembersInfoModel>[];
      json['team_members_info'].forEach((v) {
        teamMembersInfo.add(new TeamMembersInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_name'] = this.teamName;
    data['team_members_info'] =
        this.teamMembersInfo.map((v) => v.toJson()).toList();
    return data;
  }
}
