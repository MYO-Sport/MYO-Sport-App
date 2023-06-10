import 'package:us_rowing/models/RecentWorkoutModel.dart';

class WorkoutDataResponse {
  late bool status;
  late String message;
  late List<RecentWorkoutModel> recentWorkouts;

  WorkoutDataResponse(
      {required this.status,
        required this.message,
        required this.recentWorkouts,});

  WorkoutDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['recent_workouts'] != null) {
      recentWorkouts = [];
      json['recent_workouts'].forEach((v) {
        recentWorkouts.add(new RecentWorkoutModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['recent_workouts'] =
        this.recentWorkouts.map((v) => v.toJson()).toList();
    return data;
  }
}