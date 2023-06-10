import 'package:us_rowing/models/CommentContentModel.dart';

import 'CreatorModel.dart';

class CommentModel {
  late CommentContentModel comment;
  late CreatorModel commentedBy;

  CommentModel({required this.comment, required this.commentedBy});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'] != null
        ? new CommentContentModel.fromJson(json['comment'])
        : CommentContentModel(sId: '', userId: '', commentText: '');
    commentedBy = json['commented_by'] != null
        ? new CreatorModel.fromJson(json['commented_by'])
        : CreatorModel(
            sId: '', username: '', email: '', profileImage: '', type: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment.toJson();
    data['commented_by'] = this.commentedBy.toJson();
    return data;
  }
}
