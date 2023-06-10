import 'package:us_rowing/models/SavedDocModel.dart';

class SavedDocResponse {
  late bool status;
  late String message;
  late List<SavedDocModel> savedMedia;

  SavedDocResponse({required this.status, required this.savedMedia,required this.message});

  SavedDocResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['saved_media'] != null) {
      savedMedia = [];
      json['saved_media'].forEach((v) {
        savedMedia.add(new SavedDocModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['saved_media'] = this.savedMedia.map((v) => v.toJson()).toList();
    return data;
  }
}