class LikeIdModel {
  late String sId;
  late String userId;

  LikeIdModel({ required this.sId, required this.userId});

  LikeIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    return data;
  }
}