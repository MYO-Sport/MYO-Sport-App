import 'package:us_rowing/models/EquipmentModel.dart';
import 'package:us_rowing/models/SlotModel.dart';

class ReservedModel {
  late String sId;
  late int quantity;
  late List<EquipmentModel> equipments;
  late List<SlotModel> slots;

  ReservedModel({required this.sId, required this.quantity, required this.equipments, required this.slots});

  ReservedModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    if (json['equipments'] != null) {
      equipments = [];
      json['equipments'].forEach((v) {
        equipments.add(new EquipmentModel.fromJson(v));
      });
    }
    if (json['slots'] != null) {
      slots = [];
      json['slots'].forEach((v) {
        slots.add(new SlotModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quantity'] = this.quantity;
    data['equipments'] = this.equipments.map((v) => v.toJson()).toList();
    data['slots'] = this.slots.map((v) => v.toJson()).toList();
    return data;
  }
}