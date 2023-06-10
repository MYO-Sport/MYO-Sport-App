import 'package:us_rowing/models/CreatorModel.dart';

class DocumentModel {
  late String sId;
  late String media;
  late String libraryType;
  late String createrId;
  late List<CreatorModel> createrInfo;

  DocumentModel(
      {required this.sId,
        required this.media,
        required this.libraryType,
        required this.createrId,
        required this.createrInfo});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    media = json['media'];
    libraryType = json['library_type'];
    createrId = json['creater_id'];
    if (json['creater_info'] != null) {
      createrInfo = [];
      json['creater_info'].forEach((v) {
        createrInfo.add(new CreatorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['media'] = this.media;
    data['library_type'] = this.libraryType;
    data['creater_id'] = this.createrId;
    data['creater_info'] = this.createrInfo.map((v) => v.toJson()).toList();
    return data;
  }
}