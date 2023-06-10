class ReservedByModel {
  late String sId;
  late String userId;
  late String userName;
  late String userEmail;
  late String userImage;
  late String userType;
  late int quantity;

  ReservedByModel(
      {
        required this.sId,
        required this.userId,
        required this.userName,
        required this.userEmail,
        required this.userImage,
        required this.userType,
        required this.quantity});

  ReservedByModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userImage = json['user_image'];
    userType = json['user_type'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_image'] = this.userImage;
    data['user_type'] = this.userType;
    data['quantity'] = this.quantity;
    return data;
  }
}