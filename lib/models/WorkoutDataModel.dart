import 'StatModel.dart';

class WorkoutDataModel {
  late StatModel activeTime;
  late StatModel steps;
  late StatModel calories;
  late StatModel heartRate;
  late StatModel distance;
  late StatModel totalAscent;

  WorkoutDataModel(
      {required this.activeTime,
        required this.steps,
        required this.calories,
        required this.heartRate,
        required this.distance,
        required this.totalAscent});

  WorkoutDataModel.fromJson(Map<String, dynamic> json) {
    activeTime = json['active_time'] != null
        ? new StatModel.fromJson(json['active_time'])
        : StatModel(total: "0", average: "0");
    steps = json['steps'] != null ? new StatModel.fromJson(json['steps']) : StatModel(total: "0", average: "0");
    calories =
    json['calories'] != null ? new StatModel.fromJson(json['calories']) : StatModel(total: "0", average: "0");
    heartRate = json['heart_rate'] != null
        ? new StatModel.fromJson(json['heart_rate'])
        : StatModel(total: "0", average: "0");
    distance = json['distance'] != null
        ? new StatModel.fromJson(json['distance'])
        : StatModel(total: "0", average: "0");
    totalAscent = json['total_ascent'] != null
        ? new StatModel.fromJson(json['total_ascent'])
        : StatModel(total: "0", average: "0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_time'] = this.activeTime.toJson();
    data['steps'] = this.steps.toJson();
    data['calories'] = this.calories.toJson();
    data['heart_rate'] = this.heartRate.toJson();
    data['distance'] = this.distance.toJson();
    data['total_ascent'] = this.totalAscent.toJson();
    return data;
  }
}