import 'package:us_rowing/models/VideoModel.dart';

class VideosResponse {
  late bool status;
  late String message;
  late List<VideoModel> videos;

  VideosResponse({required this.status,required this.message,required this.videos});

  VideosResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos.add(new VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['videos'] = this.videos.map((v) => v.toJson()).toList();
    return data;
  }
}