
import 'package:us_rowing/models/EventModel.dart';

class MyEventDataModel {
  late String sId;
  late String status;
  late List<EventModel> event;

  MyEventDataModel({required this.sId, required this.status, required this.event});

  MyEventDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status']??'';
    if (json['event'] != null) {
      event = [];
      json['event'].forEach((v) {
        event.add(new EventModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['event'] = this.event.map((v) => v.toJson()).toList();
    return data;
  }
}