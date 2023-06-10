import 'package:us_rowing/network/body/UserInfoModel.dart';

class UserInfoResponse {
  late bool status;
  late String message;
  late UserInfoModel user;

  UserInfoResponse({required this.status,required this.user,required this.message});

  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    user = json['user'] != null ? new UserInfoModel.fromJson(json['user']) : UserInfoModel(sId: '', username: '', email: '', contactNum: '', type: '', profileImage: '', age: 0, dob: '', height: 0, port: '', sculling: '', weight: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user'] = this.user.toJson();
    return data;
  }
}