
import 'package:us_rowing/models/EventAttendantModel.dart';

class AttendantsResponse {
  late bool status;
  late String message;
  late List<EventAttendantModel> attendents;

  AttendantsResponse({required this.status, required this.message, required this.attendents});

  AttendantsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['attendents'] != null) {
      attendents = [];
      json['attendents'].forEach((v) {
        attendents.add(new EventAttendantModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['attendents'] = this.attendents.map((v) => v.toJson()).toList();
    return data;
  }
}