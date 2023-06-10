import 'package:us_rowing/models/AddressModel.dart';

class TeamMembersInfoModel {
  late String sId;
  late AddressModel address;
  late String username;
  late String profileImage;

  TeamMembersInfoModel({this.sId='', required this.address, this.username='', this.profileImage=''});

  TeamMembersInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address =
    (json['address'] != null ? new AddressModel.fromJson(json['address']) : null)!;
    username = json['username'];
    profileImage = json['profile_image']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address'] = this.address.toJson();
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
