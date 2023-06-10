import 'package:us_rowing/models/MemberModel.dart';
import 'package:us_rowing/models/PicutreModel.dart';

class ClubModel {
  late String sId;
  late PicureModel picture;
  late List<MemberModel> members;
  late List<String> associations;
  late String clubName;
  late String about;
  late String cell;
  late String address;
  late String city;
  late String location;
  late String createdAt;
  late String updatedAt;
  late int iV;

  ClubModel(
      {this.sId='',
        required this.picture,
        required this.members,
        required this.associations,
        required this.clubName,
        this.about='',
        this.cell='',
        this.address='',
        this.city='',
        this.location='',
        this.createdAt='',
        this.updatedAt='',
        this.iV=0,});

  ClubModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    picture =
    json['picture'] != null ? new PicureModel.fromJson(json['picture']) : PicureModel();
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members.add(new MemberModel.fromJson(v));
      });
    }
    associations = json['associations'] !=null ? json['associations'].cast<String>() : [];
    clubName = json['club_name']??"";
    about = json['about']??"";
    cell = json['cell']??"";
    address = json['address']??"";
    city = json['city']??"";
    location = json['location']??"";
    createdAt = json['createdAt']??"";
    updatedAt = json['updatedAt']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['picture'] = this.picture.toJson();
    data['members'] = this.members.map((v) => v.toJson()).toList();
    data['associations'] = this.associations;
    data['club_name'] = this.clubName;
    data['about'] = this.about;
    data['cell'] = this.cell;
    data['address'] = this.address;
    data['city'] = this.city;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;

    return data;
  }
}