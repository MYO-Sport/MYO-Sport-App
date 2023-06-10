class AthleteModel {
  late String sId;
  late String username;
  late String email;
  late String profileImage;

  AthleteModel({required this.sId, required this.username, required this.email, required this.profileImage});

  AthleteModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    profileImage = json['profile_image']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    return data;
  }
}