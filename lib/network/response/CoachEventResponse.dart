import 'package:us_rowing/models/EventModel.dart';

class CoachEventResponse {
  late bool status;
  late String message;
  late List<EventModel> events;

  CoachEventResponse({required this.status,required this.message,required this.events});

  CoachEventResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events.add(new EventModel.fromJson(v));
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