class CommentIdModel {
  late String sId;
  late String userId;
  late String commentText;

  CommentIdModel({ required this.sId, required this.userId, required this.commentText});

  CommentIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    commentText = json['comment_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['comment_text'] = this.commentText;
    return data;
  }
}