class UserInfoModel {
  late String sId;
  late String username;
  late String email;
  late String contactNum;
  late String type;
  late String profileImage;
  late int age;
  late String dob;
  late int height;
  late String port;
  late String sculling;
  late int weight;

  UserInfoModel(
      {
        required this.sId,
        required this.username,
        required this.email,
        required this.contactNum,
        required this.type,
        required this.profileImage,
        required this.age,
        required this.dob,
        required this.height,
        required this.port,
        required this.sculling,
        required this.weight});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    username = json['username']??'';
    email = json['email']??'';
    contactNum = json['contact_num']??'';
    type = json['type']??'';
    profileImage = json['profile_image']??'';
    age = json['age']??0;
    dob = json['dob']??'';
    height = json['height']??0;
    port = json['port']??'';
    sculling = json['sculling']??'';
    weight = json['weight']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['contact_num'] = this.contactNum;
    data['type'] = this.type;
    data['profile_image'] = this.profileImage;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['height'] = this.height;
    data['port'] = this.port;
    data['sculling'] = this.sculling;
    data['weight'] = this.weight;
    return data;
  }
}