import 'package:us_rowing/models/AddressModel.dart';
import 'package:us_rowing/models/UserModel.dart';

class CompleteProfileResponse {
  late bool status;
  late String message;
  late UserModel saveUser;

  CompleteProfileResponse({required this.status, required this.message, required this.saveUser});

  CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    saveUser = json['saveUser'] != null
        ? new UserModel.fromJson(json['saveUser'])
        : UserModel(address: AddressModel(), club: [], team: []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['saveUser'] = this.saveUser.toJson();
    return data;
  }
}
