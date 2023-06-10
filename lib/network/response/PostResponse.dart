import 'package:us_rowing/models/FeedModel.dart';

class PostResponse {
  late bool status;
  late FeedModel post;

  PostResponse({required this.status, required this.post});

  PostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    post = json['post'] != null ? new FeedModel.fromJson(json['post']) : FeedModel(sId: '', visible: false, feedText: '', postType: '', createdAt: '', updatedAt: '', media: [], createrInfo: [], likes: [], comments: [], isLiked: false, mediaType: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['post'] = this.post.toJson();
    return data;
  }
}