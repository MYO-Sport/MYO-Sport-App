import 'package:us_rowing/models/EventDataModel.dart';

class MyEventsResponse {
  late bool status;
  late String message;
  late List<EventDataModel> events;

  MyEventsResponse({ required this.status,required this.message,required this.events});

  MyEventsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    data['message'] = this.message;
    data['events'] = this.events.map((v) => v.toJson()).toList();
    return data;
  }
}