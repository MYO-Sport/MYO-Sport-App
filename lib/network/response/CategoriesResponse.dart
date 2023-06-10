import 'package:us_rowing/models/EqCategoryModel.dart';

class CategoriesResponse {
  late bool status;
  late String message;
  late List<EqCategoryModel> categories;

  CategoriesResponse({required this.status,required this.message, required this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(new EqCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['categories'] = this.categories.map((v) => v.toJson()).toList();
    return data;
  }
}