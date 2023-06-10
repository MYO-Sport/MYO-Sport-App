class WorkOutActivities {
  late String sId;
  late String activityName;
  late String typeId;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late String valueType;
  late String isRequired;
  late String unit;

  WorkOutActivities(
      {this.sId='',
        this.activityName='',
        this.typeId='',
        this.createdAt='',
        this.updatedAt='',
        this.iV=0,
        required this.valueType,
        required this.isRequired,
        required this.unit,
      });

  WorkOutActivities.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    unit = json['unit']??'';
    activityName = json['activity_name'];
    typeId = json['type_id'];
    createdAt = json['createdAt'];
    valueType = json['value_type']??'';
    updatedAt = json['updatedAt'];
    iV = json['__v']??0;
    isRequired = json['isRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['unit'] = this.unit;
    data['activity_name'] = this.activityName;
    data['type_id'] = this.typeId;
    data['value_type'] = this.valueType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isRequired'] = this.isRequired;
    return data;
  }
}