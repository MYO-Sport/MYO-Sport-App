class ActivityModel {
  late String activityId;
  late String activityName;
  late var value;
  late String valType;
  late String unit;

  ActivityModel({required this.activityId, required this.activityName, required this.value,required this.valType,required this.unit});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id']??'';
    activityName = json['activity_name']??'';
    value = json['value']??'';
    valType = json['value_type']??'';
    unit = json['unit']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['activity_name'] = this.activityName;
    data['value'] = this.value;
    data['value_type'] = this.valType;
    data['unit'] = this.unit;
    return data;
  }
}