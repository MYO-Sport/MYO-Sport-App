import 'package:us_rowing/models/EquipmentModel.dart';

class EquipmentsResponse {
  late bool status;
  late String message;
  late List<EquipmentModel> equipments;

  EquipmentsResponse({required this.status,required this.message, required this.equipments});

  EquipmentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['equipments'] != null) {
      equipments = [];
      json['equipments'].forEach((v) {
        equipments.add(new EquipmentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['equipments'] = this.equipments.map((v) => v.toJson()).toList();
    return data;
  }
}