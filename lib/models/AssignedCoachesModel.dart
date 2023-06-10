import 'package:us_rowing/models/AddressModel.dart';

import 'CoachModel.dart';

class AssignedCoachModel {
  late CoachModel coach;
  late String roomId;

  AssignedCoachModel({required this.coach, required this.roomId});

  AssignedCoachModel.fromJson(Map<String, dynamic> json) {
    coach = json['coach'] != null ? new CoachModel.fromJson(json['coach']) : CoachModel(sId: '', address: AddressModel(), team: [], club: [], username: '', email: '', contactNum: '', type: '', password: '', speciality: '', createdAt: '', updatedAt: '', iV: 0, role: '', athletes: [], profileImage: '');
    roomId = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coach'] = this.coach.toJson();
    data['room_id'] = this.roomId;
    return data;
  }
}