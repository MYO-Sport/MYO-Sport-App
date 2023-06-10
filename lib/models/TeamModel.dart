import 'package:us_rowing/models/PicutreModel.dart';

import 'MemberModel.dart';

class TeamModel {
  late String sId;
  late PicureModel picture;
  late List<MemberModel> members;
  late List<String> associations;
  late String teamName;
  late String about;
  late String cell;
  late String address;
  late String city;
  late String location;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late String email;

  TeamModel(
      {required this.sId,
        required this.picture,
        required this.members,
        required this.associations,
        required this.teamName,
        required this.about,
        required this.cell,
        required this.address,
        required this.city,
        required this.location,
        required this.createdAt,
        required this.updatedAt,
        required this.iV,
        required this.email});

  TeamModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    picture =
    json['picture'] != null ? new PicureModel.fromJson(json['picture']) : PicureModel();
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members.add(new MemberModel.fromJson(v));
      });
    }
    associations = json['associations'].cast<String>();
    teamName = json['team_name'];
    about = json['about'];
    cell = json['cell'];
    address = json['address'];
    city = json['city'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    email = json['email']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['picture'] = this.picture.toJson();
    data['members'] = this.members.map((v) => v.toJson()).toList();
    data['associations'] = this.associations;
    data['team_name'] = this.teamName;
    data['about'] = this.about;
    data['cell'] = this.cell;
    data['address'] = this.address;
    data['city'] = this.city;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['email'] = this.email;
    return data;
  }
}