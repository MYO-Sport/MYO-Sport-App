import 'package:us_rowing/models/SavedVideoModel.dart';

class SavedVideoResponse {
  late bool status;
  late String message;
  late List<SavedVideoModel> savedVideos;

  SavedVideoResponse({required this.status, required this.savedVideos,required this.message});

  SavedVideoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['saved_videos'] != null) {
      savedVideos = [];
      json['saved_videos'].forEach((v) {
        savedVideos.add(new SavedVideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['saved_videos'] = this.savedVideos.map((v) => v.toJson()).toList();
    return data;
  }
}