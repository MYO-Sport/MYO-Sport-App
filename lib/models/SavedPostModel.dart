import 'package:us_rowing/models/FeedModel.dart';

class SavedPostModel {
  late FeedModel post;

  SavedPostModel({required this.post});

  SavedPostModel.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new FeedModel.fromJson(json['post']) : FeedModel(sId: '', visible: false, feedText: '', postType: '', createdAt: '', updatedAt: '', media: [], createrInfo: [], likes: [], comments: [], isLiked: false, mediaType: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post'] = this.post.toJson();
    return data;
  }
}