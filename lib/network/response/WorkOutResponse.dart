import 'package:us_rowing/models/WorkoutsModel.dart';

class WorkOutResponse {
  late bool status=true;
  late String message='Successful';
  late List<WorkoutsModel> workouts;

  WorkOutResponse({required this.workouts});

  WorkOutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['workouts'] != null) {
      workouts = <WorkoutsModel>[];
      json['workouts'].forEach((v) {
        workouts.add(new WorkoutsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['workouts'] = this.workouts.map((v) => v.toJson()).toList();
    return data;
  }
}