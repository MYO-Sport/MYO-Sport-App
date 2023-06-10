import 'package:us_rowing/models/RoomModel.dart';

class RoomsResponse {
  late bool status;
  late String message;
  late List<RoomModel> rooms;

  RoomsResponse({required this.status, required this.message, required this.rooms});

  RoomsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms.add(new RoomModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    return data;
  }
}