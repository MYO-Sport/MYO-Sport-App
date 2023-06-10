import 'package:us_rowing/models/TeamDetailsModel.dart';

class TeamDetailsResponse {
  late bool status=true;
  late String message='Successful';
  late List<TeamDetailsModel> teams;

  TeamDetailsResponse({required this.teams});

  TeamDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['teams'] != null) {
      teams = <TeamDetailsModel>[];
      json['teams'].forEach((v) {
        teams.add(new TeamDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['teams'] = this.teams.map((v) => v.toJson()).toList();
    return data;
  }
}