import 'package:us_rowing/models/WorkOutActivitiesModel.dart';

class WorkoutsModel {
  late String sId;
  late String workoutName;
  late String typeId;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late String workoutImage;
  late List<WorkOutActivities> activities;

  WorkoutsModel(
      {this.sId='',
        this.workoutName='',
        this.typeId='',
        this.createdAt='',
        this.updatedAt='',
        this.iV=0,
        this.workoutImage='',
        required this.activities});

  WorkoutsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    workoutName = json['workout_name'];
    typeId = json['type_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    workoutImage = json['workout_image']??'';
    if (json['activities'] != null) {
      activities = <WorkOutActivities>[];
      json['activities'].forEach((v) {
        activities.add(new WorkOutActivities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['workout_name'] = this.workoutName;
    data['type_id'] = this.typeId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['workout_image'] = this.workoutImage;
    data['activities'] = this.activities.map((v) => v.toJson()).toList();
    return data;
  }
}
