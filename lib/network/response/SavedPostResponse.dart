import 'package:us_rowing/models/SavedPostModel.dart';

class SavedPostResponse {
  late bool status;
  late String message;
  late List<SavedPostModel> savedPosts;

  SavedPostResponse({required this.status, required this.savedPosts,required this.message});

  SavedPostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['saved_posts'] != null) {
      savedPosts = [];
      json['saved_posts'].forEach((v) {
        savedPosts.add(new SavedPostModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['saved_posts'] = this.savedPosts.map((v) => v.toJson()).toList();
    return data;
  }
}