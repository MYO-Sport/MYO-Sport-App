import 'package:us_rowing/models/AthleteModel.dart';

class AttendantModel {
  late String sId;
  late List<AthleteModel> attendents;

  AttendantModel({required this.sId, required this.attendents});

  AttendantModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['attendents'] != null) {
      attendents =  [];
      json['attendents'].forEach((v) {
        attendents.add(new AthleteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['attendents'] = this.attendents.map((v) => v.toJson()).toList();
    return data;
  }
}