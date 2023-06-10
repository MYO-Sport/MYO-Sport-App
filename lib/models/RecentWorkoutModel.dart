class RecentWorkoutModel {
  late String sId;
  late String workoutId;
  late String workoutName;
  late String type;
  late String userId;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late String workoutImage;

  RecentWorkoutModel(
      {
        required this.sId,
        required this.workoutId,
        required this.workoutName,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.iV,
        required this.type,
      required this.workoutImage});

  RecentWorkoutModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    workoutId = json['workout_id']??'';
    type = json['type']??'';
    workoutName = json['workout_name'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    workoutImage = json['workout_image']??'';
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['workout_id'] = this.workoutId;
    data['type'] = this.type;
    data['workout_name'] = this.workoutName;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['workout_image'] = this.workoutImage;
    data['__v'] = this.iV;
    return data;
  }
}