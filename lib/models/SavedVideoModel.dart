import 'package:us_rowing/models/VideoModel.dart';

class SavedVideoModel {
  late VideoModel video;

  SavedVideoModel({required this.video});

  SavedVideoModel.fromJson(Map<String, dynamic> json) {
    video = json['video'] != null ? new VideoModel.fromJson(json['video']) : VideoModel(sId: '', createrId: '', media: '', createdAt: '', updatedAt: '', createrInfo: [], videoType: '', mediaType: '', iV: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video.toJson();
    return data;
  }
}