import 'package:us_rowing/models/TeamInfoModel.dart';

class TeamDetailsModel {
  late String sId;
  late TeamInfoModel teamInfo;

  TeamDetailsModel({this.sId='', required this.teamInfo});

  TeamDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    teamInfo = (json['team_info'] != null
        ? new TeamInfoModel.fromJson(json['team_info'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['team_info'] = this.teamInfo.toJson();
    return data;
  }
}