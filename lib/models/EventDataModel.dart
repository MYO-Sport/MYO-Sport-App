import 'package:us_rowing/models/EventModel.dart';
import 'package:us_rowing/models/LocationModel.dart';

class EventDataModel {
  late EventModel event;
  late int status;

  EventDataModel({required this.event, required this.status});

  EventDataModel.fromJson(Map<String, dynamic> json) {
    event = json['event'] != null
        ? new EventModel.fromJson(json['event'])
        : EventModel(
            sId: '',
            date: '',
            eventType: '',
            name: '',
            description: '',
            createrId: '',
            clubId: '',
            createdAt: '',
            updatedAt: '',
            iV: 0,
            createrInfo: [],
            startDate: '',
            endDate: '',
            location: LocationModel(type: '', coordinates: []),
            attendants: []);
    status = json['status'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event.toJson();
    data['status'] = this.status;
    return data;
  }
}
