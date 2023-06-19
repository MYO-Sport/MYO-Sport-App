import 'package:us_rowing/models/AddressModel.dart';
import 'package:us_rowing/models/ClubIdModel.dart';
import 'package:us_rowing/models/TeamIdModel.dart';

class UserModel {
  late AddressModel address;
  late String role;
  late String sId;
  late String username;
  late String memberNumber;
  late String email;
  late String contactNum;
  late String type;
  late String password;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late List<ClubIdModel> club;
  late List<TeamIdModel> team;
  late String profileImage;
  late int age;
  late String dob;
  late int height;
  late int weight;
  late String port;
  late String starboard;
  late String sculling;

  UserModel.abc({
    this.username = '',
    this.email = '',

  });

  UserModel(
      {required this.address,
      this.role = '',
      this.sId = '',
      this.username = '',
      this.email = '',
      this.contactNum = '',
      this.type = '',
      this.password = '',
      this.createdAt = '',
      this.updatedAt = '',
      this.iV = 0,
      required this.club,
      required this.team,
      this.profileImage = '',
      this.age = 0,
      this.weight = 0,
      this.starboard = '',
      this.sculling = '',
      this.dob = '',
      this.height = 0,
      this.port = '',
      this.memberNumber = ''});

  UserModel.fromJson(Map<String, dynamic> json) {
    address = (json['address'] != null
        ? new AddressModel.fromJson(json['address'])
        : AddressModel());
    role = json['role'] ?? '';
    sId = json['_id'] ?? '';
    username = json['username'] ?? '';
    memberNumber = json['membership_number'] ?? '';
    email = json['email'] ?? '';
    contactNum = json['contact_num'] ?? '';
    type = json['type'] ?? '';
    password = json['password'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    profileImage = json['profile_image'] ?? '';
    age = json['age'] ?? 0;
    weight = json['weight'] ?? 0;
    starboard = json['starboard'] ?? '';
    sculling = json['sculling'] ?? '';
    dob = json['dob'] ?? '';
    height = json['height'] ?? 0;
    port = json['port'] ?? '';

    iV = json['__v'] ?? 0;
    if (json['club'] != null) {
      club = <ClubIdModel>[];
      json['club'].forEach((v) {
        club.add(new ClubIdModel.fromJson(v));
      });
    }
    if (json['team'] != null) {
      team = <TeamIdModel>[];
      json['team'].forEach((v) {
        team.add(new TeamIdModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address.toJson();
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['contact_num'] = this.contactNum;
    data['type'] = this.type;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['club'] = this.club.map((v) => v.toJson()).toList();
    data['team'] = this.team.map((v) => v.toJson()).toList();
    data['profile_image'] = this.profileImage;
    data['membership_number'] = this.memberNumber;

    data['age'] = this.age;
    data['weight'] = this.weight;
    data['starboard'] = this.starboard;
    data['sculling'] = this.sculling;
    data['dob'] = this.dob;
    data['height'] = this.height;
    data['port'] = this.port;

    return data;
  }
}
