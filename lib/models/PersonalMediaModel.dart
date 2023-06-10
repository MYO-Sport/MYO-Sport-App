
class VideoModel {
  late String sId;
  late String createrId;
  late String media;
  late String createdAt;
  late String updatedAt;
  late String videoType;
  late String mediaType;
  late int iV;

  VideoModel(
      {
        required this.sId,
        required this.createrId,
        required this.media,
        required this.createdAt,
        required this.updatedAt,
        required this.videoType,
        required this.mediaType,
        required this.iV});

  VideoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createrId = json['creater_id'];
    media = json['media'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    videoType = json['video_type']??'';
    mediaType = json['media_type']??'';
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['creater_id'] = this.createrId;
    data['media'] = this.media;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['video_type'] = this.videoType;
    data['media_type'] = this.mediaType;
    data['__v'] = this.iV;
    return data;
  }
}