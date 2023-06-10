import 'package:us_rowing/models/FeedModel.dart';

class HomePostResponse {
  late bool status;
  late String message;
  late List<FeedModel> clubPosts;
  late List<FeedModel> teamPosts;

  HomePostResponse({required this.status,required this.message, required this.clubPosts, required this.teamPosts});

  HomePostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['club_posts'] != null) {
      clubPosts = [];
      json['club_posts'].forEach((v) {
        clubPosts.add(new FeedModel.fromJson(v));
      });
    }
    if (json['team_posts'] != null) {
      teamPosts = [];
      json['team_posts'].forEach((v) {
        teamPosts.add(new FeedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['club_posts'] = this.clubPosts.map((v) => v.toJson()).toList();
    data['team_posts'] = this.teamPosts.map((v) => v.toJson()).toList();
    return data;
  }
}