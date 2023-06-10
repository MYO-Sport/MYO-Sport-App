import 'package:us_rowing/models/ReservedModel.dart';

class ReservedResponse {
  late bool status;
  late String message;
  late List<ReservedModel> reservations;

  ReservedResponse({required this.status, required this.message, required this.reservations});

  ReservedResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reservations'] != null) {
      reservations = [];
      json['reservations'].forEach((v) {
        reservations.add(new ReservedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['reservations'] = this.reservations.map((v) => v.toJson()).toList();
    return data;
  }
}