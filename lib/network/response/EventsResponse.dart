import 'package:us_rowing/models/EventDataModel.dart';

class EventsResponse {
  late bool status;
  List<EventDataModel> events=[];

  EventsResponse({required this.status, required this.events});

  EventsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events.add(new EventDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['events'] = this.events.map((v) => v.toJson()).toList();
    return data;
  }
}