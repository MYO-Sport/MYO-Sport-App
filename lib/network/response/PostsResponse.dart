import 'package:us_rowing/models/FeedModel.dart';

class PostsResponse {
  late bool status;
  late String message;
  late List<FeedModel> feed;

  PostsResponse({ required this.status, required this.message, required this.feed});

  PostsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['posts'] != null) {
      feed = [];
      json['posts'].forEach((v) {
        feed.add(new FeedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['posts'] = this.feed.map((v) => v.toJson()).toList();
    return data;
  }
}