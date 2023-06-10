import 'package:us_rowing/models/AddressModel.dart';
import 'package:us_rowing/models/UserModel.dart';

class UserResponse {
  late bool status;
  late String message;
  late UserModel response;
  late bool verified;

  UserResponse({this.status=false, this.message='', required this.response,required this.verified});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    verified = json['verified']??true;
    response = (json['response'] != null
        ? new UserModel.fromJson(json['response'])
        : UserModel(address: AddressModel(), club: [], team: []));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['verified'] = this.verified;
    data['response'] = this.response.toJson();
    return data;
  }
}