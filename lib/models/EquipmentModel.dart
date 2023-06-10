import 'package:us_rowing/models/EqCategoryModel.dart';

class EquipmentModel {
  late String sId;
  late String equipmentName;
  late String equipmentImage;
  late String categoryId;
  late String equipmentDescription;
  late String clubId;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late List<EqCategoryModel> category;

  EquipmentModel(
      {
        required this.sId,
        required this.equipmentName,
        required this.equipmentImage,
        required this.categoryId,
        required this.equipmentDescription,
        required this.clubId,
        required this.createdAt,
        required this.updatedAt,
        required this.iV,
        required this.category});

  EquipmentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    equipmentName = json['equipment_name']??'';
    equipmentImage = json['equipment_image']??'';
    categoryId = json['category_id']??'';
    equipmentDescription = json['equipment_description']??'';
    clubId = json['club_id']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    iV = json['__v']??0;
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category.add(new EqCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['equipment_name'] = this.equipmentName;
    data['equipment_image'] = this.equipmentImage;
    data['category_id'] = this.categoryId;
    data['equipment_description'] = this.equipmentDescription;
    data['club_id'] = this.clubId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['category'] = this.category.map((v) => v.toJson()).toList();
    return data;
  }
}