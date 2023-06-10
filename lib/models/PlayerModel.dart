import 'package:us_rowing/models/MemberModel.dart';

class PlayerModel {
  late String clubId;
  late String clubName;
  late String image;
  late List<MemberModel> members;

  PlayerModel({required this.clubId,required  this.clubName,required  this.members,required this.image});

  PlayerModel.fromJson(Map<String, dynamic> json) {
    clubId = json['club_id']??'';
    clubName = json['club_name']??'';
    image = json['club_image']??'';
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members.add(new MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['club_id'] = this.clubId;
    data['club_name'] = this.clubName;
    data['club_image'] = this.image;
    data['members'] = this.members.map((v) => v.toJson()).toList();
    return data;
  }
}