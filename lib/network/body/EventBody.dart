import 'package:us_rowing/models/TimeModel.dart';

class EventBody {
  late String name;
  late String date;
  late TimeModel startTime;
  late TimeModel endTime;
  late String status;
  late String eventType;
  late String description;
  late String createrId;
  late String timeZone;
  late String clubId;
  late String teamId;

  late String startDate;
  late String endDate;
  late String repeat;
  late String lat;
  late String lng;

  EventBody(
      {
        required this.name,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.status,
        required this.eventType,
        required this.description,
        required this.createrId,
        required this.timeZone,
        required this.clubId,
        required this.lat,
        required this.lng,
        required this.startDate,
        required this.endDate,
        required this.repeat,
      required this.teamId});

  EventBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    startTime = json['start_time'] != null
        ? new TimeModel.fromJson(json['start_time'])
        : TimeModel(value: '', amOrPm: '');
    endTime = json['end_time'] != null
        ? new TimeModel.fromJson(json['end_time'])
        : TimeModel(value: '', amOrPm: '');
    status = json['status'];

    startDate = json['start_date'];
    endDate = json['end_date'];
    repeat = json['repeat'];
    lat = json['lat'];
    lng = json['lon'];

    eventType = json['event_type'];
    description = json['description'];
    createrId = json['creater_id'];
    timeZone = json['time_zone'];
    clubId = json['club_id'];
    clubId = json['team_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['start_time'] = this.startTime.toJson();
    data['end_time'] = this.endTime.toJson();
    data['status'] = this.status;

    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['lon'] = this.lng;
    data['lat'] = this.lat;
    data['repeat'] = this.repeat;



    data['event_type'] = this.eventType;
    data['description'] = this.description;
    data['creater_id'] = this.createrId;
    data['time_zone'] = this.timeZone;
    data['club_id'] = this.clubId;
    data['team_id'] = this.teamId;
    return data;
  }
}