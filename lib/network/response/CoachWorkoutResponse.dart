import 'package:us_rowing/models/AthleteModel.dart';

class CoachWorkoutResponse {
  late bool status;
  late String message;
  late List<AthleteModel> athletes;

  CoachWorkoutResponse({required this.status, required this.message, required this.athletes});

  CoachWorkoutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['athletes'] != null) {
      athletes = [];
      json['athletes'].forEach((v) {
        athletes.add(new AthleteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['athletes'] = this.athletes.map((v) => v.toJson()).toList();
    return data;
  }
}
