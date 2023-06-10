import 'package:us_rowing/models/CreatorModel.dart';
import 'package:us_rowing/models/EventAttendantModel.dart';
import 'package:us_rowing/models/LocationModel.dart';

class EventModel {
  late String sId;
  late String date;
  late String eventType;
  late String name;
  late String description;
  late String createrId;
  late String clubId;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late String startDate;
  late String endDate;
  late List<CreatorModel> createrInfo;
  late LocationModel location;
  late List<EventAttendantModel> attendants;

  EventModel(
      {required this.sId,
      required this.date,
      required this.eventType,
      required this.name,
      required this.description,
      required this.createrId,
      required this.clubId,
      required this.createdAt,
      required this.updatedAt,
      required this.iV,
      required this.createrInfo,
      required this.location,
      required this.endDate,
      required this.startDate,
      required this.attendants});

  EventModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'] ?? '';
    eventType = json['event_type'] ?? '';
    name = json['name'];
    startDate = json['name'];
    description = json['description'];
    createrId = json['creater_id'];
    clubId = json['club_id'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    iV = json['__v'] ?? 0;
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    location = json['loc'] != null
        ? new LocationModel.fromJson(json['loc'])
        : LocationModel(type: '', coordinates: []);
    if (json['attendents'] != null) {
      attendants = [];
      json['attendents'].forEach((v) {
        attendants.add(new EventAttendantModel.fromJson(v));
      });
    }
    if (json['creater_info'] != null) {
      createrInfo = [];
      json['creater_info'].forEach((v) {
        createrInfo.add(new CreatorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['event_type'] = this.eventType;
    data['name'] = this.name;
    data['description'] = this.description;
    data['creater_id'] = this.createrId;
    data['club_id'] = this.clubId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['loc'] = this.location.toJson();
    data['attendents'] = this.createrInfo.map((v) => v.toJson()).toList();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['creater_info'] = this.createrInfo.map((v) => v.toJson()).toList();

    return data;
  }
}
