import 'package:us_rowing/models/SlotModel.dart';

class SlotsResponse {
  late bool status;
  late String message;
  late List<SlotModel> slots;

  SlotsResponse({required this.status, required this.message, required this.slots});

  SlotsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['slots'] != null) {
      slots = [];
      json['slots'].forEach((v) {
        slots.add(new SlotModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['slots'] = this.slots.map((v) => v.toJson()).toList();
    return data;
  }
}