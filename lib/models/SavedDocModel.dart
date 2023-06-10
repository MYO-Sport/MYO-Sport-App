import 'package:us_rowing/models/DocumentModel.dart';

class SavedDocModel {
  late DocumentModel media;

  SavedDocModel({required this.media});

  SavedDocModel.fromJson(Map<String, dynamic> json) {
    media = json['media'] != null ? new DocumentModel.fromJson(json['media']) : DocumentModel(sId: '', media: '', libraryType: '', createrId: '', createrInfo: []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media'] = this.media.toJson();
    return data;
  }
}