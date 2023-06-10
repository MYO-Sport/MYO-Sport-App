import 'package:us_rowing/models/CreatorModel.dart';

class LikeModel {
  late String sId;
  late List<CreatorModel> likedBy;

  LikeModel({required this.sId, required this.likedBy});

  LikeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['liked_by'] != null) {
      likedBy = [];
      json['liked_by'].forEach((v) {
        likedBy.add(new CreatorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['liked_by'] = this.likedBy.map((v) => v.toJson()).toList();
    return data;
  }
}
