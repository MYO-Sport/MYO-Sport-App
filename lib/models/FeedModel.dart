import 'package:us_rowing/models/CommentIdModel.dart';
import 'package:us_rowing/models/CreatorModel.dart';
import 'package:us_rowing/models/LikeIdModel.dart';

class FeedModel {
  late String sId;
  late bool visible;
  late String feedText;
  late String postType;
  late String createdAt;
  late String updatedAt;
  late List<String> media;
  late List<CreatorModel> createrInfo;
  late List<LikeIdModel> likes;
  late List<CommentIdModel> comments;
  late bool isLiked;
  late String mediaType;

  FeedModel(
      {required this.sId,
        required this.visible,
        required this.feedText,
        required this.postType,
        required this.createdAt,
        required this.updatedAt,
        required this.media,
        required this.createrInfo,
        required this.likes,
        required this.comments,
        required this.isLiked,
        required this.mediaType});

  FeedModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    visible = json['visible'];
    feedText = json['feed_text'];
    postType = json['post_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    media = json['media'].cast<String>();
    isLiked = json['is_liked']=false;
    if (json['creater_info'] != null) {
      createrInfo = [];
      json['creater_info'].forEach((v) {
        createrInfo.add(new CreatorModel.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes.add(new LikeIdModel.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(new CommentIdModel.fromJson(v));
      });
    }
    mediaType = json['media_type']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['visible'] = this.visible;
    data['feed_text'] = this.feedText;
    data['post_type'] = this.postType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['media'] = this.media;
    data['creater_info'] = this.createrInfo.map((v) => v.toJson()).toList();
    data['likes'] = this.likes.map((v) => v.toJson()).toList();
    data['comments'] = this.comments.map((v) => v.toJson()).toList();
    data['media_type'] = this.mediaType;
    data['is_liked'] = this.isLiked;
    return data;
  }
}