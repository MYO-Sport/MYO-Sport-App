import 'package:us_rowing/models/AddressModel.dart';
import 'package:us_rowing/models/AthleteIdModel.dart';
import 'package:us_rowing/models/ClubIdModel.dart';
import 'package:us_rowing/models/TeamIdModel.dart';

class CoachModel {
  late String sId;
  late AddressModel address;
  late List<TeamIdModel> team;
  late List<ClubIdModel> club;
  late String username;
  late String email;
  late String contactNum;
  late String type;
  late String password;
  late String speciality;
  late String createdAt;
  late String updatedAt;
  late int iV;
  late String role;
  late List<AthleteIdModel> athletes;
  late String profileImage;

  CoachModel(
      {
        required this.sId,
        required this.address,
        required this.team,
        required this.club,
        required this.username,
        required this.email,
        required this.contactNum,
        required this.type,
        required this.password,
        required this.speciality,
        required this.createdAt,
        required this.updatedAt,
        required this.iV,
        required this.role,
        required this.athletes,
        required this.profileImage,
      });

  CoachModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address =
    json['address'] != null ? new AddressModel.fromJson(json['address']) : AddressModel();
    if (json['team'] != null) {
      team = [];
      json['team'].forEach((v) {
        team.add(new TeamIdModel.fromJson(v));
      });
    }
    if (json['club'] != null) {
      club = [];
      json['club'].forEach((v) {
        club.add(new ClubIdModel.fromJson(v));
      });
    }
    username = json['username'];
    email = json['email'];
    contactNum = json['contact_num'];
    type = json['type'];
    password = json['password'];
    speciality = json['speciality']??'';
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    role = json['role'];
    profileImage = json['profile_image']??'';
    if (json['athletes'] != null) {
      athletes = [];
      json['athletes'].forEach((v) {
        athletes.add(new AthleteIdModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address'] = this.address.toJson();
    data['team'] = this.team.map((v) => v.toJson()).toList();
    data['club'] = this.club.map((v) => v.toJson()).toList();
    data['username'] = this.username;
    data['email'] = this.email;
    data['contact_num'] = this.contactNum;
    data['type'] = this.type;
    data['password'] = this.password;
    data['speciality'] = this.speciality;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['role'] = this.role;
    data['profile_image'] = this.profileImage;
    data['athletes'] = this.athletes.map((v) => v.toJson()).toList();
    return data;
  }
}