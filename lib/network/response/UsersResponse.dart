import 'package:us_rowing/models/UserModel.dart';

class UsersResponse {
  late bool status;
  late String message;
  late List<UserModel> users;

  UsersResponse({required this.status,required this.message,required this.users});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['users'] = this.users.map((v) => v.toJson()).toList();
    return data;
  }
}