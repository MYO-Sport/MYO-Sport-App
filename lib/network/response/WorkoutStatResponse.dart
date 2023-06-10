
import 'package:us_rowing/models/StatModel.dart';
import 'package:us_rowing/models/WorkoutDataModel.dart';

class WorkoutStatResponse {
  late bool status;
  late String message;
  late WorkoutDataModel averageOfAllWorkouts;

  WorkoutStatResponse(
      {required this.status,
        required this.message,
        required this.averageOfAllWorkouts});

  WorkoutStatResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    averageOfAllWorkouts = json['average_of_all_workouts'] != null
        ? new WorkoutDataModel.fromJson(json['average_of_all_workouts'])
        : WorkoutDataModel(activeTime: StatModel(total: "0", average: "0"),  heartRate: StatModel(total: "0", average: "0"), steps: StatModel(total: "0", average: "0"), calories: StatModel(total: "0", average: "0"),  distance: StatModel(total: "0", average: "0"), totalAscent: StatModel(total: "0", average: "0"));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['average_of_all_workouts'] = this.averageOfAllWorkouts.toJson();
    return data;
  }
}