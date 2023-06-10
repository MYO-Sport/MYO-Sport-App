class MemberModel {
  late String sId;
  late String username;
  late String email;
  late String type;
  late String memberId;
  late String profilePic;
  late String role;

  MemberModel({required this.sId, required this.username,required this.email,required this.type,required this.memberId, required this.profilePic, required this.role});

  MemberModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username']??'';
    email = json['email']??'';
    type = json['type']??'';
    memberId = json['member_id']??'';
    profilePic = json['profile_image']??'';
    role = json['role']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['type'] = this.type;
    data['member_id'] = this.memberId;
    data['profile_image'] = this.profilePic;
    data['role'] = this.role;
    return data;
  }
}