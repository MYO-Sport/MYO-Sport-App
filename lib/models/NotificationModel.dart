class NotificationModel {
  late List<String> postMedia;
  late String sId;
  late String type;
  late String createrId;
  late String createrName;
  late String message;
  late String postId;
  late String userId;
  late String createrImage;
  late String postMediaType;
  late String createdAt;
  late String updatedAt;
  late int iV;

  NotificationModel(
      {
        required this.postMedia,
        required this.sId,
        required this.type,
        required this.createrId,
        required this.createrName,
        required this.message,
        required this.postId,
        required this.userId,
        required this.createrImage,
        required this.postMediaType,
        required this.createdAt,
        required this.updatedAt,
        required this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    postMedia = json['post_media'].cast<String>()??[];
    sId = json['_id']??'';
    type = json['type']??'';
    createrId = json['creater_id']??'';
    createrName = json['creater_name']??'';
    message = json['message']??'';
    postId = json['post_id']??'';
    userId = json['user_id']??'';
    createrImage = json['creater_image']??'';
    postMediaType = json['post_media_type']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_media'] = this.postMedia;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['creater_id'] = this.createrId;
    data['creater_name'] = this.createrName;
    data['message'] = this.message;
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['creater_image'] = this.createrImage;
    data['post_media_type'] = this.postMediaType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}