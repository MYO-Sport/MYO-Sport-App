class EventAttendantModel {
  late String sId;
  late String userId;
  late String userName;
  late String userType;
  late String userProfileImage;
  late String userEmail;
  late String status;

  EventAttendantModel(
      {
        required this.sId,
        required this.userId,
        required this.userName,
        required this.userType,
        required this.userProfileImage,
        required this.userEmail,
        required this.status});

  EventAttendantModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    userId = json['user_id'];
    userName = json['user_name'];
    userType = json['user_type'];
    userProfileImage = json['user_profile_image']??'';
    userEmail = json['user_email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_type'] = this.userType;
    data['user_profile_image'] = this.userProfileImage;
    data['user_email'] = this.userEmail;
    data['status'] = this.status;
    return data;
  }
}