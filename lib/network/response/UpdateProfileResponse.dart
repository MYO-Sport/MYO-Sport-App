class UpdateProfileResponse {
  late bool status;
  late String message;
  late String profileImage;

  UpdateProfileResponse({ required this.status, required this.message, required this.profileImage});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['profile_image'] = this.profileImage;
    return data;
  }
}