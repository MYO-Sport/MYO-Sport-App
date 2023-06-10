import 'package:us_rowing/models/ActivityModel.dart';

class WorkoutBody {
  late String userId;
  late String workoutId;
  late List<ActivityModel> activities;

  WorkoutBody({required this.userId, required this.workoutId, required this.activities});

  WorkoutBody.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    workoutId = json['workout_id'];
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities.add(new ActivityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['workout_id'] = this.workoutId;
    data['activities'] = this.activities.map((v) => v.toJson()).toList();
    return data;
  }
}