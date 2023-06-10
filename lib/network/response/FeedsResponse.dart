import 'package:us_rowing/models/FeedModel.dart';

class FeedsResponse {
  late bool status;
  late String message;
  late List<FeedModel> feed;

  FeedsResponse({ required this.status, required this.message, required this.feed});

  FeedsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['feed'] != null) {
      feed = [];
      json['feed'].forEach((v) {
        feed.add(new FeedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['feed'] = this.feed.map((v) => v.toJson()).toList();
    return data;
  }
}