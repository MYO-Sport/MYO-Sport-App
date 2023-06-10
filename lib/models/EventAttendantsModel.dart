import 'package:us_rowing/models/CreatorModel.dart';

class EventAttendantsModel {
  late List<CreatorModel> users;

  EventAttendantsModel({required this.users});

  EventAttendantsModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users.add(new CreatorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users'] = this.users.map((v) => v.toJson()).toList();
    return data;
  }
}