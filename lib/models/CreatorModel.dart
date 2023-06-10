class CreatorModel {
  late String sId;
  late String username;
  late String email;
  late String profileImage;
  late String type;

  CreatorModel({required this.sId, required this.username, required this.email, required this.profileImage,required this.type});

  CreatorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    username = json['username']??'';
    email = json['email']??'';
    profileImage = json['profile_image']??'';
    type=json['type']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['type'] = this.type;
    return data;
  }
}